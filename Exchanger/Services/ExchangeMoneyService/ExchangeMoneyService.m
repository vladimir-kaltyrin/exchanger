#import "ExchangeMoneyService.h"

@implementation ExchangeMoneyService

// MARK: - IExchangeMoneyService

- (void)exchange:(MoneyData *)moneyData
      toCurrency:(Currency *)currency
        onResult:(void (^)(MoneyData *))onResult
{
    Currency *resultCurrency = [self calculateFromCurrency:moneyData.currency
                                                toCurrency:currency];
    
    MoneyData *resultMoneyData = [self exchangeMoneyData:moneyData
                                            withCurrency:resultCurrency];
    
    onResult(resultMoneyData);
}

// MARK: - Private

- (MoneyData *)exchangeMoneyData:(MoneyData *)moneyData
                    withCurrency:(Currency *)currency
{
    MoneyData *resultMoneyData = [[MoneyData alloc] init];
    resultMoneyData.amount = @(moneyData.amount.floatValue * currency.rate.floatValue);
    resultMoneyData.currency = currency;
    
    return resultMoneyData;
}

- (Currency *)calculateFromCurrency:(Currency *)fromCurrency
                         toCurrency:(Currency *)toCurrency
{
    Currency *result = [[Currency alloc] init];
    result.currencyType = toCurrency.currencyType;
    result.rate = @(toCurrency.rate.floatValue / fromCurrency.rate.floatValue);
    
    return result;
}

@end
