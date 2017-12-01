#import <Foundation/Foundation.h>
#import "ExchangeRatesUpdater.h"

@interface ExchangeRatesUpdaterImpl : NSObject<ExchangeRatesUpdater>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithExchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService;

@end
