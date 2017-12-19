#import "ExchangeRatesData.h"

typedef void (^OnFetchRates)(ExchangeRatesData *);
typedef void (^OnError)(NSError *);

@protocol NetworkClient

- (void)fetchRates:(OnFetchRates)onData
           onError:(OnError)onError;

@end
