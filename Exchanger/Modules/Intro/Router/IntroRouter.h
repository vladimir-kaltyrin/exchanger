#import <Foundation/Foundation.h>
#import "ExchangeMoneyModule.h"

@protocol IntroRouter <NSObject>

- (void)showAbout;

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure;

@end
