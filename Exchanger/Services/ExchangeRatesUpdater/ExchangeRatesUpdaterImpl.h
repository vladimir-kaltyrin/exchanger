#import <Foundation/Foundation.h>
#import "ExchangeRatesUpdater.h"

@interface ExchangeRatesUpdaterImpl : NSObject<ExchangeRatesUpdater>

- (instancetype)initWithExchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService;

@end
