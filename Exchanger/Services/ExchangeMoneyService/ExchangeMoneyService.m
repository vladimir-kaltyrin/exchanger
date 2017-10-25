#import "ExchangeMoneyService.h"

@implementation ExchangeMoneyService

// MARK: - IExchangeMoneyService

- (void)exchangeMoney:(NSNumber *)money
       sourceCurrency:(Currency *)sourceCurrency
       targetCurrency:(Currency *)targetCurrency
             onResult:(void(^)(MoneyData *))onResult;
{
    __weak typeof(self) weakSelf = self;
    [self convertedCurrencyWithSourceCurrency:sourceCurrency targetCurrency:targetCurrency onConvert:^(Currency *convertedCurrency) {
        MoneyData *resultMoneyData = [weakSelf exchangeMoney:money
                                            withCurrency:convertedCurrency];
        onResult(resultMoneyData);
    }];
}

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                             targetCurrency:(Currency *)targetCurrency
                                  onConvert:(void (^)(Currency *))onConvert
{
    Currency *result = [[Currency alloc] init];
    result.currencyType = targetCurrency.currencyType;
    result.rate = @(targetCurrency.rate.floatValue / sourceCurrency.rate.floatValue);
    
    onConvert(result);
}

// MARK: - Private

- (MoneyData *)exchangeMoney:(NSNumber *)money
                    withCurrency:(Currency *)currency
{
    MoneyData *resultMoneyData = [[MoneyData alloc] init];
    resultMoneyData.amount = @(money.floatValue * currency.rate.floatValue);
    resultMoneyData.currencyType = currency.currencyType;
    
    return resultMoneyData;
}


@end
