#import <Foundation/Foundation.h>
#import "MoneyData.h"

@protocol ExchangeMoneyInteractor <NSObject>

- (void)setOnUpdate:(void(^)())onUpdate;

- (void)startFetching;

- (void)exchange:(void(^)(MoneyData *))onExchange;

@end
