#import "ExchangeMoneyServiceImpl.h"
#import "Wallet.h"

@implementation ExchangeMoneyServiceImpl

// MARK: - ExchangeMoneyService

- (void)exchangeMoney:(NSNumber *)money
       sourceCurrency:(Currency *)sourceCurrency
       targetCurrency:(Currency *)targetCurrency
             onResult:(void(^)(Wallet *))onResult;
{
    __weak typeof(self) weakSelf = self;
    [self convertedCurrencyWithSourceCurrency:sourceCurrency targetCurrency:targetCurrency onConvert:^(Currency *convertedCurrency) {
        Wallet *wallet = [weakSelf exchangeMoney:money
                                    withCurrency:convertedCurrency];
        onResult(wallet);
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

- (Wallet *)exchangeMoney:(NSNumber *)money
             withCurrency:(Currency *)currency
{
    return [[Wallet alloc] initWithCurrency:currency
                                     amount:@(money.floatValue * currency.rate.floatValue)];
}


@end
