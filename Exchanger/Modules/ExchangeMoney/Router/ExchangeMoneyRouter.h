#import <Foundation/Foundation.h>
#import "BaseRouter.h"

@protocol ExchangeMoneyRouter <NSObject>
- (void)dismissModule;
@end

@interface ExchangeMoneyRouterImpl : BaseRouter<ExchangeMoneyRouter>

@end
