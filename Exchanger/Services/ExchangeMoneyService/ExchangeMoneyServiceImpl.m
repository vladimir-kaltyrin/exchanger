#import "ExchangeMoneyServiceImpl.h"
#import "Wallet.h"
#import "ConvenientObjC.h"

@implementation ExchangeMoneyServiceImpl

// MARK: - ExchangeMoneyService

- (void)exchangeWithUser:(User *)user
             moneyAmount:(NSNumber *)moneyAmount
          sourceCurrency:(Currency *)sourceCurrency
          targetCurrency:(Currency *)targetCurrency
                onResult:(void (^)(ExchangeMoneyResult *))onResult
{
    __weak typeof(self) welf = self;
    [self convertedCurrencyWithSourceCurrency:sourceCurrency
                               targetCurrency:targetCurrency
                                    onConvert:^(Currency *convertedCurrency)
    {
        
        let sourceWallet = [welf sourceWalletWith:user
                                         currency:sourceCurrency
                                      moneyAmount:moneyAmount];
        
        let walletDiff = [welf exchangeMoneyAmount:moneyAmount
                                      withCurrency:convertedCurrency];
        
        let targetWallet = [welf targetWalletWith:user
                                         currency:targetCurrency
                                       walletDiff:walletDiff];
        
        let result = [[ExchangeMoneyResult alloc] initWithSourceWallet:sourceWallet
                                                          targetWallet:targetWallet];
        safeBlock(onResult, result);
    }];
}

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                             targetCurrency:(Currency *)targetCurrency
                                  onConvert:(void (^)(Currency *))onConvert
{
    var result = [[Currency alloc] init];
    result.currencyType = targetCurrency.currencyType;
    result.rate = [self calculateExchangeRateWithSourceCurrency:sourceCurrency targetCurrency:targetCurrency];
    
    safeBlock(onConvert, result);
}

- (void)exchangeWallet:(Wallet *)wallet
        targetCurrency:(Currency *)currency
              onResult:(void (^)(Wallet *wallet))onResult
{
    __weak typeof(self) welf = self;
    [self convertedCurrencyWithSourceCurrency:wallet.currency
                               targetCurrency:currency
                                    onConvert:^(Currency *convertedCurrency)
    {
        let resultWallet = [welf exchangeMoneyAmount:wallet.amount
                                                withCurrency:convertedCurrency];
        
        safeBlock(onResult, resultWallet);
    }];
}

// MARK: - Private

- (NSNumber *)calculateExchangeRateWithSourceCurrency:(Currency *)sourceCurrency
                                       targetCurrency:(Currency *)targetCurrency
{
    return @(targetCurrency.rate.floatValue / sourceCurrency.rate.floatValue);
}

- (Wallet *)sourceWalletWith:(User *)user
                    currency:(Currency *)currency
                 moneyAmount:(NSNumber *)moneyAmount
{
    let userSourceWallet = [user walletWithCurrencyType:currency.currencyType];
    
    return [[Wallet alloc] initWithCurrency:currency
                                    amount:@(userSourceWallet.amount.doubleValue - moneyAmount.doubleValue)];
}

- (Wallet *)targetWalletWith:(User *)user
                    currency:(Currency *)currency
                  walletDiff:(Wallet *)walletDiff
{
    let userTargetWallet = [user walletWithCurrencyType:currency.currencyType];
    
    return [[Wallet alloc] initWithCurrency:currency
                                     amount:@(userTargetWallet.amount.doubleValue + walletDiff.amount.doubleValue)];
}

- (Wallet *)exchangeMoneyAmount:(NSNumber *)moneyAmount
                   withCurrency:(Currency *)currency
{
    return [[Wallet alloc] initWithCurrency:currency
                                     amount:@(moneyAmount.floatValue * currency.rate.floatValue)];
}


@end
