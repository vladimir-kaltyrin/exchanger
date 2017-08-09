#import <Foundation/Foundation.h>
#import "MoneyData.h"
#import "ExchangeRatesData.h"

@protocol ExchangeMoneyInteractor <NSObject>

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate;

- (void)startFetching;

- (void)exchange:(void(^)(MoneyData *))onExchange;

@end
