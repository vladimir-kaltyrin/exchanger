#import "ConvenientObjC.h"
#import "ExchangeMoneyViewDataBuilder.h"
#import "User.h"
#import "CarouselData.h"
#import "FormatterFactoryImpl.h"
#import "CurrencyExchangeType.h"

@interface ExchangeMoneyViewDataBuilder()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@property (nonatomic, strong) FormatterResultData *incomeInput;
@property (nonatomic, strong) FormatterResultData *expenseInput;
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;
@property (nonatomic, strong) NSNumber *invertedRate;
@property (nonatomic, assign) BOOL isDeficiency;
@property (nonatomic, strong) OnInputChange onInputChange;
@property (nonatomic, strong) id<RoundingFormatter> roundingFormatter;
@end

@implementation ExchangeMoneyViewDataBuilder

// MARK: - Init

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(FormatterResultData *)incomeInput
                expenseInput:(FormatterResultData *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                invertedRate:(NSNumber *)invertedRate
                isDeficiency:(BOOL)isDeficiency
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
        self.invertedRate = invertedRate;
        self.isDeficiency = isDeficiency;
        self.onInputChange = onInputChange;
        
        self.roundingFormatter = [[FormatterFactoryImpl instance] roundingFormatter];
    }
    return self;
}

// MARK: - Public

- (ExchangeMoneyViewData *)build {
    
    let sourceData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType];
    
    let targetData = [self previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType];
    
    return [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                  targetData:targetData];
}

// MARK: - Private

- (CarouselPageData *)sourceCurrencyPageDataWithCurrency:(Currency *)currency {
    let currencyTitle = currency.currencyCode;
    let remainder = [self balanceWithUser:self.user currencyType:currency.currencyType];
    let rate = @"";
    
    CarouselPageRemainderStyle remainderStyle;
    if (self.isDeficiency) {
        remainderStyle = CarouselPageRemainderStyleDeficiency;
    } else {
        remainderStyle = CarouselPageRemainderStyleNormal;
    }
    
    OnTextChange onTextChange = ^(NSString *text) {
        safeBlock(self.onInputChange, text, CurrencyExchangeSourceType, currency.currencyType);
    };
    
    return [[CarouselPageData alloc] initWithCurrencyTitle:currencyTitle
                                                           input:self.expenseInput.formattedString
                                                       remainder:remainder
                                                            rate:rate
                                                  remainderStyle:remainderStyle
                                                    onTextChange:onTextChange];
    
}

- (CarouselPageData *)targetCurrencyPageDataWithCurrency:(Currency *)currency {
    let currencyTitle = currency.currencyCode;
    let remainder = [self balanceWithUser:self.user currencyType:currency.currencyType];
    let rate = [NSString stringWithFormat:@"%@1 = %@%@",
                currency.currencySign,
                self.sourceCurrency.currencySign,
                [self.roundingFormatter format:self.invertedRate]];
    
    let remainderStyle = CarouselPageRemainderStyleNormal;
    
    OnTextChange onTextChange = ^(NSString *text) {
        safeBlock(self.onInputChange, text, CurrencyExchangeTargetType, currency.currencyType);
    };
    
    return [[CarouselPageData alloc] initWithCurrencyTitle:currencyTitle
                                                     input:self.incomeInput.formattedString
                                                 remainder:remainder
                                                      rate:rate
                                            remainderStyle:remainderStyle
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
    
    return [[CarouselData alloc] initWithPages:pages
                                   currentPage:currentPage];
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    let wallet = [user walletWithCurrencyType:currencyType];
    let currency = wallet.currency;
    return [NSString stringWithFormat:@"You have %@%@",
            currency.currencySign,
            [self.roundingFormatter format:wallet.amount]];
}

@end
