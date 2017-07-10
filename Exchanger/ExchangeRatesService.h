#import <Foundation/Foundation.h>
#import "ExchangeRatesData.h"

typedef void (^OnExchangeRatesServiceSuccess)(ExchangeRatesData *);
typedef void (^OnExchangeRatesServiceFailure)(NSError *);

@protocol IExchangeRatesService <NSObject>
- (void)fetchRates:(OnExchangeRatesServiceSuccess)onData
           onError:(OnExchangeRatesServiceFailure)onError;
@end

@interface ExchangeRatesService : NSObject<IExchangeRatesService>
@end
