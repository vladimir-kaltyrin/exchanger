#import "ExchangeRatesUpdater.h"
#import "ExchangeRatesService.h"

@interface ExchangeRatesUpdater()
@property (nonatomic, strong) id<IExchangeRatesService> exchangeRatesService;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ExchangeRatesUpdater

// MARK: - Init

- (instancetype)initWithExchangeRatesService:(id<IExchangeRatesService>)exchangeRatesService {
    self = [super init];
    if (self) {
        self.exchangeRatesService = exchangeRatesService;
        [self reset];
    }
    
    return self;
}

- (void)reset {
    self.timer = [NSTimer timerWithTimeInterval:100 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.exchangeRatesService fetchRates:^(ExchangeRatesData *data) {
            
        } onError:^(NSError *error) {
            
        }];
    }];
}

// MARK: - IExchangeRatesUpdater

- (void)onUpdate:(void (^)(ExchangeRatesData *))onUpdate {
    
}

- (void)start {
    
}

- (void)stop {
    
}

@end
