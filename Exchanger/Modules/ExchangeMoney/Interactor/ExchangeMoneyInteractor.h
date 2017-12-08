#import <Foundation/Foundation.h>
#import "Wallet.h"
#import "CurrencyExchangeType.h"
#import "ExchangeRatesData.h"
#import "User.h"

@protocol ExchangeMoneyInteractor <NSObject>
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;

- (void)convertedCurrency:(void(^)(Currency *))onConvert;

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate;

- (void)startFetching;

- (void)exchangeCurrency:(NSNumber *)currencyAmount
              onExchange:(void(^)())onExchange
                 onError:(void(^)())onError;

- (void)fetchUser:(void(^)(User *))onUser;

- (void)fetchRates:(void(^)(ExchangeRatesData *))onRates
           onError:(void(^)(NSError *))onError;

- (void)resetCurrenciesWithData:(ExchangeRatesData *)data onReset:(void(^)())onReset;

- (void)exchangeWallet:(Wallet *)wallet
        targetCurrency:(Currency *)currency
              onResult:(void(^)(Wallet *wallet, NSNumber *invertedRate))onResult;

@end
