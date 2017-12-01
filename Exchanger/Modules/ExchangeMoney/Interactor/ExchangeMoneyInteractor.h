#import <Foundation/Foundation.h>
#import "Wallet.h"
#import "ExchangeRatesData.h"
#import "User.h"

@protocol ExchangeMoneyInteractor <NSObject>
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;

- (void)convertedCurrency:(void(^)(Currency *))onConvert;

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate;

- (void)startFetching;

- (void)exchange:(void(^)(Wallet *))onExchange;

- (void)fetchUser:(void(^)(User *))onUser;

- (void)fetchRates:(void(^)(ExchangeRatesData *))onRates
           onError:(void(^)(NSError *))onError;

- (void)resetCurrenciesWithData:(ExchangeRatesData *)data onReset:(void(^)())onReset;

@end
