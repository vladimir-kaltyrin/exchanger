#import <Foundation/Foundation.h>
#import "MoneyData.h"
#import "ExchangeRatesData.h"
#import "User.h"

@protocol ExchangeMoneyInteractor <NSObject>
@property (nonatomic, strong) Currency *sourceCurrency;
@property (nonatomic, strong) Currency *targetCurrency;

- (void)convertedCurrency:(void(^)(Currency *))onConvert;

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate;

- (void)startFetching;

- (void)exchange:(void(^)(MoneyData *))onExchange;

- (void)fetchUser:(void(^)(User *))onUser;

@end
