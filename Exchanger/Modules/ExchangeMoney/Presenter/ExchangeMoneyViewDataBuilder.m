#import <ObjectiveSugar/ObjectiveSugar.h>
#import "ExchangeMoneyViewDataBuilder.h"
#import "User.h"
#import "CarouselData.h"
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
@property (nonatomic, strong) TextFieldAttributedStringFormatter sourceInputFormatter;
@property (nonatomic, strong) TextFieldAttributedStringFormatter targetInputFormatter;
@property (nonatomic, strong) OnInputChange onInputChange;
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
        sourceInputFormatter:(TextFieldAttributedStringFormatter)sourceInputFormatter
        targetInputFormatter:(TextFieldAttributedStringFormatter)targetInputFormatter
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
        self.sourceInputFormatter = sourceInputFormatter;
        self.targetInputFormatter = targetInputFormatter;
        self.onInputChange = onInputChange;
        
        self.roundingFormatter = [[FormatterFactoryImpl instance] roundingFormatter];
    }
    return self;
}

// MARK: - Public

- (ExchangeMoneyViewData *)build {
    
    CarouselData *sourceData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType];
    
    CarouselData *targetData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType];
    
    ExchangeMoneyViewData *viewData = [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                                             targetData:targetData];
    
    return viewData;
}

// MARK: - Private

- (CarouselPageData *)sourceCurrencyPageDataWithCurrency:(Currency *)currency {
    NSString *currencyTitle = currency.currencyCode;
    NSString *remainder = [self balanceWithUser:self.user currencyType:currency.currencyType];
    NSString *rate = @"";
    
    NSString *input;
    if (self.activeExchangeRate == CurrencyExchangeSourceType) {
        input = self.expenseInput;
    } else {
        input = self.sourceInputFormatter(self.incomeInput).string;
    };
    
    CarouselPageRemainderStyle remainderStyle;
    if (self.isDeficiency) {
        remainderStyle = CarouselPageRemainderStyleDeficiency;
    } else {
        remainderStyle = CarouselPageRemainderStyleNormal;
    }
    
    OnTextChange onTextChange = ^(NSString *text) {
        block(self.onInputChange, text, CurrencyExchangeSourceType, currency.currencyType);
    };
    
    return [[CarouselPageData alloc] initWithCurrencyTitle:currencyTitle
                                                           input:input
                                                       remainder:remainder
                                                            rate:rate
                                                  remainderStyle:remainderStyle
                                                  inputFormatter:self.sourceInputFormatter
                                                    onTextChange:onTextChange];
    
}

- (CarouselPageData *)targetCurrencyPageDataWithCurrency:(Currency *)currency {
    NSString *currencyTitle = currency.currencyCode;
    NSString *remainder = [self balanceWithUser:self.user currencyType:currency.currencyType];
    NSString *rate = [NSString stringWithFormat:@"%@1 = %@%@",
                      currency.currencySign,
                      self.sourceCurrency.currencySign,
                      [self.roundingFormatter format:self.invertedRate]];
    
    NSString *input;
    if (self.activeExchangeRate == CurrencyExchangeTargetType) {
        input = self.incomeInput;
    } else {
        input = self.targetInputFormatter(self.expenseInput).string;
    };
    
    CarouselPageRemainderStyle remainderStyle = CarouselPageRemainderStyleNormal;
    
    OnTextChange onTextChange = ^(NSString *text) {
        block(self.onInputChange, text, CurrencyExchangeTargetType, currency.currencyType);
    };
    
    return [[CarouselPageData alloc] initWithCurrencyTitle:currencyTitle
                                                           input:input
                                                       remainder:remainder
                                                            rate:rate
                                                  remainderStyle:remainderStyle
                                                  inputFormatter:self.targetInputFormatter
                                                    onTextChange:onTextChange];
    
}

- (CarouselData *)previewDataWithCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType
{
    NSArray<CarouselPageData *> *pages;
    switch (currencyExchangeType) {
        case CurrencyExchangeSourceType:
        {
            pages = [self.currencies map:^id(id currency) {
                return [self sourceCurrencyPageDataWithCurrency:currency];
            }];
        }
            break;
        case CurrencyExchangeTargetType:
        {
            pages = [self.currencies map:^id(id currency) {
                return [self targetCurrencyPageDataWithCurrency:currency];
            }];
        }
            break;
    }
    
    NSInteger currentPage = [self.currencies indexOfObjectPassingTest:^BOOL(Currency * _Nonnull currency, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
    CarouselData *viewData = [[CarouselData alloc] initWithPages:pages
                                                     currentPage:currentPage];
    
    return viewData;
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    Wallet *wallet = [user walletWithCurrencyType:currencyType];
    Currency *currency = wallet.currency;
    return [NSString stringWithFormat:@"You have %@%@",
            currency.currencySign,
            [self.roundingFormatter format:wallet.amount]];
}

@end
