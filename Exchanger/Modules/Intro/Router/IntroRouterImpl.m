#import "IntroRouterImpl.h"
#import "AssembledViewController.h"
#import "SafeBlocks.h"

@implementation IntroRouterImpl

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure {
    
    id<ExchangeMoneyAssembly> assembly = [self.assemblyFactory exchangeMoneyAssembly];
    AssembledViewController *assembledViewController = [assembly module];
    
    block(configure, assembledViewController.module);
    
    [self push:assembledViewController.viewController animated:YES];
}

@end
