#import "ExchangeMoneyViewDataBuilder.h"
#import "User.h"
#import "GalleryPreviewData.h"
#import "FormatterFactoryImpl.h"
#import "CurrencyExchangeType.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyViewDataBuilder()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@property (nonatomic, strong) NSString *incomeInput;
@property (nonatomic, strong) NSString *expenseInput;
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;
@property (nonatomic, strong) Wallet *targetWallet;
@property (nonatomic, strong) NSNumber *invertedRate;
@property (nonatomic, assign) BOOL isDeficiency;
@property (nonatomic, assign) CurrencyExchangeType activeExchangeRate;
@property (nonatomic, strong) OnInputChange onInputChange;
@property (nonatomic, strong) id<NumbersFormatter> numbersFormatter;
@property (nonatomic, strong) id<BalanceFormatter> exchangeCurrencyInputFormatter;
@property (nonatomic, strong) id<RoundingFormatter> roundingFormatter;
@end

@implementation ExchangeMoneyViewDataBuilder

// MARK: - Init

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(NSString *)incomeInput
                expenseInput:(NSString *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                targetWallet:(Wallet *)targetWallet
                invertedRate:(NSNumber *)invertedRate
                isDeficiency:(BOOL)isDeficiency
          activeExchangeRate:(CurrencyExchangeType)activeExchangeRate
               onInputChange:(OnInputChange)onInputChange
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
        self.isDeficiency = isDeficiency;
        self.activeExchangeRate = activeExchangeRate;
        self.onInputChange = onInputChange;
        
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
        NSString *input;
        GalleryPreviewPageRemainderStyle remainderStyle = GalleryPreviewPageRemainderStyleNormal;
        TextFieldAttributedStringFormatter inputFormatter;
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
            {
                rate = @"";
                
                inputFormatter = ^(NSString *text) {
                    NSString *numberText;
                    if (self.activeExchangeRate == CurrencyExchangeSourceType) {
                        numberText = [self.numbersFormatter format:text];
                    } else {
                        numberText = targetWallet.amount.stringValue;
                    }
                    
                    FormatterResultData *data = [self formattedExpenseInput:numberText];
                    return data;
                };
                
                if (self.activeExchangeRate == CurrencyExchangeSourceType) {
                    input = self.expenseInput;
                } else {
                    input = inputFormatter(self.incomeInput).string;
                };
                
                if (self.isDeficiency) {
                    remainderStyle = GalleryPreviewPageRemainderStyleDeficiency;
                } else {
                    remainderStyle = GalleryPreviewPageRemainderStyleNormal;
                }
            }
                break;
            case CurrencyExchangeTargetType:
            {
                
                inputFormatter = ^(NSString *text) {
                    NSString *numberText;
                    if (self.activeExchangeRate == CurrencyExchangeTargetType) {
                        numberText = [self.numbersFormatter format:text];
                    } else {
                        numberText = targetWallet.amount.stringValue;
                    }
                    
                    FormatterResultData *data = [self formattedIncomeInput:numberText];
                    return data;
                };
                
                if (self.activeExchangeRate == CurrencyExchangeTargetType) {
                    input = self.incomeInput;
                } else {
                    input = inputFormatter(self.expenseInput).string;
                };
                
                rate = [NSString stringWithFormat:@"%@1 = %@%@",
                        currency.currencySign,
                        self.sourceCurrency.currencySign,
                        [self.roundingFormatter format:invertedRate]];
            }                break;
        }
        
        OnTextChange onTextChange = ^(NSString *text) {
            block(self.onInputChange, text, currencyExchangeType);
        };
        
        GalleryPreviewPageData *pageData = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:currencyTitle
                                                                                           input:input
                                                                                       remainder:remainder
                                                                                            rate:rate
                                                                                  remainderStyle:remainderStyle
                                                                                  inputFormatter:inputFormatter
                                                                                    onTextChange:onTextChange];
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
    return [self.exchangeCurrencyInputFormatter format:expenseInput sign:BalanceFormatterSignMinus];
}

- (FormatterResultData *)formattedIncomeInput:(NSString *)incomeInput {
    return [self.exchangeCurrencyInputFormatter format:incomeInput sign:BalanceFormatterSignPlus];
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    Wallet *wallet = [user walletWithCurrencyType:currencyType];
    Currency *currency = wallet.currency;
    return [NSString stringWithFormat:@"You have %@%@",
            currency.currencySign,
            [self.roundingFormatter format:wallet.amount]];
}

@end
