#import "ExchangeRatesUpdaterImpl.h"
#import "ExchangeRatesService.h"
#import "SafeBlocks.h"

NSTimeInterval const kUpdateFrequency = 30.0f;

@interface ExchangeRatesUpdaterImpl()
@property (nonatomic, strong) id<ExchangeRatesService> exchangeRatesService;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ExchangeRatesUpdaterImpl
@synthesize onUpdate;
@synthesize onError;

// MARK: - Init

- (instancetype)initWithExchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService
{
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
    
    self.timer = [NSTimer timerWithTimeInterval:kUpdateFrequency target:self selector:@selector(fetch) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)fetch {
    __weak typeof(self) welf = self;
    [self.exchangeRatesService fetchRates:^(ExchangeRatesData *data) {
        block(welf.onUpdate, data);
    } onError:^(NSError *error) {
        block(welf.onError, error);
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
