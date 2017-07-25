#import <Foundation/Foundation.h>
#import "ExchangeRatesData.h"

typedef void (^OnExchangeRatesServiceSuccess)(ExchangeRatesData *);
typedef void (^OnExchangeRatesServiceFailure)(NSError *);

@protocol ExchangeRatesService <NSObject>
- (void)fetchRates:(OnExchangeRatesServiceSuccess)onData
           onError:(OnExchangeRatesServiceFailure)onError;
@end
