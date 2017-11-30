#import <Foundation/Foundation.h>
#import "ExchangeMoneyModule.h"

@protocol IntroRouter <NSObject>

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure;

@end
