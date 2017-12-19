#import <Foundation/Foundation.h>
#import "ExchangeRatesService.h"
#import "NetworkClient.h"

@interface ExchangeRatesServiceImpl : NSObject<ExchangeRatesService>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithNetworkClient:(id<NetworkClient>)networkClient;

@end
