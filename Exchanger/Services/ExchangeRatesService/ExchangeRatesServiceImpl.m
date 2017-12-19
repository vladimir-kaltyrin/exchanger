#import "ExchangeRatesServiceImpl.h"
#import "ConvenientObjC.h"

@interface ExchangeRatesServiceImpl()
@property (nonatomic, strong) id<NetworkClient> networkClient;
@end

@implementation ExchangeRatesServiceImpl

- (instancetype)initWithNetworkClient:(id<NetworkClient>)networkClient; {
    if (self = [super init]) {
        self.networkClient = networkClient;
    }
    return self;
}

- (void)fetchRates:(OnExchangeRatesServiceSuccess)onData
           onError:(OnExchangeRatesServiceFailure)onError
{
    [self.networkClient fetchRates:onData
                           onError:onError];
}

@end
