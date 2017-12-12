#import "ExchangeMoneyViewDataBuilder.h"
#import "User.h"
#import "GalleryPreviewData.h"
#import "FormatterFactoryImpl.h"
#import "CurrencyExchangeType.h"

@interface ExchangeMoneyViewDataBuilder()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@property (nonatomic, strong) NSNumber *incomeInput;
@property (nonatomic, strong) NSNumber *expenseInput;
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;
@property (nonatomic, strong) Wallet *targetWallet;
@property (nonatomic, strong) NSNumber *invertedRate;
@property (nonatomic, strong) OnTextChange onTextChange;
@property (nonatomic, strong) id<NumbersFormatter> numbersFormatter;
@property (nonatomic, strong) id<BalanceFormatter> exchangeCurrencyInputFormatter;
@property (nonatomic, strong) id<RoundingFormatter> roundingFormatter;
@end

@implementation ExchangeMoneyViewDataBuilder

// MARK: - Init

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(NSNumber *)incomeInput
                expenseInput:(NSNumber *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                targetWallet:(Wallet *)targetWallet
                invertedRate:(NSNumber *)invertedRate
                onTextChange:(OnTextChange)onTextChange
{
    self = [super init];
    if (self) {
        self.user = user;
        self.currencies = currencies;
        self.incomeInput = incomeInput;
        self.expenseInput = expenseInput;
        self.sourceCurrency = sourceCurrency;
        self.targetCurrency = targetCurrency;
        self.targetWallet = targetWallet;
        self.invertedRate = invertedRate;
        self.onTextChange = onTextChange;
        
        self.numbersFormatter = [[FormatterFactoryImpl instance] numbersFormatter];
        self.exchangeCurrencyInputFormatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
        self.roundingFormatter = [[FormatterFactoryImpl instance] roundingFormatter];
    }
    return self;
}

// MARK: - Public

- (ExchangeMoneyViewData *)build {
    
    GalleryPreviewData *sourceData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType
                                                                          user:self.user
                                                                    currencies:self.currencies
                                                                  targetWallet:self.targetWallet
                                                                  invertedRate:self.invertedRate];
    
    GalleryPreviewData *targetData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType
                                                                          user:self.user
                                                                    currencies:self.currencies
                                                                  targetWallet:self.targetWallet
                                                                  invertedRate:self.invertedRate];
    
    ExchangeMoneyViewData *viewData = [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                                             targetData:targetData];
    
    return viewData;
}

// MARK: - Private

- (GalleryPreviewData *)previewDataWithCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType
                                                       user:(User *)user
                                                 currencies:(NSArray<Currency *> *)currencies
                                               targetWallet:(Wallet *)targetWallet
                                               invertedRate:(NSNumber *)invertedRate
{
    NSMutableArray<GalleryPreviewPageData *> *pages = [NSMutableArray array];
    
    for (Currency *currency in currencies) {
        
        NSString *currencyTitle = currency.currencyCode;
        NSString *remainder = [self balanceWithUser:user currencyType:currency.currencyType];
        NSString *rate;
        NSAttributedString *currencyAmount;
        NSString *input;
        GalleryPreviewPageRemainderStyle remainderStyle = GalleryPreviewPageRemainderStyleNormal;
        TextFieldAttributedStringFormatter inputFormatter;
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
            {
                rate = @"";
                
                inputFormatter = ^(NSString *text) {
                    NSString *numberText = [self.numbersFormatter format:text];
                    FormatterResultData *data = [self formattedExpenseInput:numberText];
                    return data;
                };
                
                //currencyAmount = [self formattedExpenseInput:self.expenseInput];
                input = self.expenseInput.stringValue;
                
                if ([self checkUserHasBalanceDeficiency:user currency:currency]) {
                    remainderStyle = GalleryPreviewPageRemainderStyleDeficiency;
                } else {
                    remainderStyle = GalleryPreviewPageRemainderStyleNormal;
                }
            }
                break;
            case CurrencyExchangeTargetType:
            {
                NSNumber *targetAmount = targetWallet.amount;
                NSString *targetInput;
                if (targetAmount.floatValue > 0) {
                    targetInput = [NSString stringWithFormat:@"+%@", targetAmount];
                } else {
                    targetInput = targetAmount.stringValue;
                }
                
                currencyAmount = [self.exchangeCurrencyInputFormatter format:targetInput].formattedString;
                input = self.incomeInput.stringValue;
                
                rate = [NSString stringWithFormat:@"%@1 = %@%@",
                        currency.currencySign,
                        self.sourceCurrency.currencySign,
                        [self.roundingFormatter format:invertedRate]];
            }                break;
        }
        
        
        
        GalleryPreviewPageData *pageData = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:currencyTitle
                                                                                           input:input
                                                                                       remainder:remainder
                                                                                            rate:rate
                                                                                  remainderStyle:remainderStyle
                                                                                  inputFormatter:inputFormatter
                                                                                    onTextChange:self.onTextChange];
        [pages addObject:pageData];
    }
    
    NSInteger currentPage = [currencies indexOfObjectPassingTest:^BOOL(Currency * _Nonnull currency, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
                return currency.currencyType == self.sourceCurrency.currencyType;
                break;
            case CurrencyExchangeTargetType:
                return currency.currencyType == self.targetCurrency.currencyType;
                break;
        }
    }];
    
    if (currentPage == NSNotFound) {
        currentPage = 0;
    }
    
    GalleryPreviewData *viewData = [[GalleryPreviewData alloc] initWithPages:pages
                                                                 currentPage:currentPage
                                                                       onTap:nil];
    
    return viewData;
}

- (FormatterResultData *)formattedExpenseInput:(NSString *)expenseInput {
    NSString *input;
    if (expenseInput.floatValue > 0) {
        input = [NSString stringWithFormat:@"-%@", expenseInput];
    } else {
        input = expenseInput;
    }
    
    return [self.exchangeCurrencyInputFormatter format:input];
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    Wallet *wallet = [user walletWithCurrencyType:currencyType];
    Currency *currency = wallet.currency;
    return [NSString stringWithFormat:@"You have %@%@",
            currency.currencySign,
            [self.roundingFormatter format:wallet.amount]];
}

- (BOOL)checkUserHasBalanceDeficiency:(User *)user currency:(Currency *)currency {
    Wallet *wallet = [user walletWithCurrencyType:currency.currencyType];
    return self.expenseInput.floatValue > wallet.amount.floatValue;
}

@end
