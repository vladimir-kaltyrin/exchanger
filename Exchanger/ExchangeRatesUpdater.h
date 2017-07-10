#import <Foundation/Foundation.h>
#import "ExchangeRatesData.h"
#import "ExchangeRatesService.h"

@protocol IExchangeRatesUpdater <NSObject>
- (void)start;
- (void)stop;
- (void)onUpdate:(void(^)(ExchangeRatesData *))onUpdate;
@end

@interface ExchangeRatesUpdater : NSObject<IExchangeRatesUpdater>

- (instancetype)initWithExchangeRatesService:(id<IExchangeRatesService>)exchangeRatesService;

@end
