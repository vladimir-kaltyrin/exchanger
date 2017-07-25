#import <Foundation/Foundation.h>
#import "ExchangeRatesData.h"
#import "ExchangeRatesService.h"

@protocol ExchangeRatesUpdater <NSObject>

@property (nonatomic, strong) void(^onUpdate)(ExchangeRatesData *);

@property (nonatomic, strong) void(^onError)(NSError *);

- (void)start;

- (void)stop;
@end
