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
                                                           input:self.expenseInput.formattedString
                                                       remainder:remainder
                                                            rate:rate
                                                  remainderStyle:remainderStyle
                                                    onTextChange:onTextChange];
    
}

- (CarouselPageData *)targetCurrencyPageDataWithCurrency:(Currency *)currency {
    NSString *currencyTitle = currency.currencyCode;
    NSString *remainder = [self balanceWithUser:self.user currencyType:currency.currencyType];
    NSString *rate = [NSString stringWithFormat:@"%@1 = %@%@",
                      currency.currencySign,
                      self.sourceCurrency.currencySign,
                      [self.roundingFormatter format:self.invertedRate]];
    
    CarouselPageRemainderStyle remainderStyle = CarouselPageRemainderStyleNormal;
    
    OnTextChange onTextChange = ^(NSString *text) {
        block(self.onInputChange, text, CurrencyExchangeTargetType, currency.currencyType);
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
