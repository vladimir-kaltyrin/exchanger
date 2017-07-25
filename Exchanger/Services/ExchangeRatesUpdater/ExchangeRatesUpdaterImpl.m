#import "ExchangeRatesUpdaterImpl.h"
#import "ExchangeRatesService.h"
#import "SafeBlocks.h"

@interface ExchangeRatesUpdaterImpl()
@property (nonatomic, strong) id<ExchangeRatesService> exchangeRatesService;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ExchangeRatesUpdaterImpl
@synthesize onUpdate;
@synthesize onError;

// MARK: - Init

- (instancetype)initWithExchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService {
    self = [super init];
    if (self) {
        self.exchangeRatesService = exchangeRatesService;
        [self reset];
    }
    
    return self;
}

// MARK: - Private

- (void)reset {
    [self stop];
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:100 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf fetch];
    }];
}

- (void)fetch {
    __weak typeof(self) weakSelf = self;
    [self.exchangeRatesService fetchRates:^(ExchangeRatesData *data) {
        executeIfNotNil(weakSelf.onUpdate, data);
    } onError:^(NSError *error) {
        executeIfNotNil(weakSelf.onError, error);
    }];
}

// MARK: - ExchangeRatesUpdater

- (void)start {
    [self reset];
    [self fetch];
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

@end
