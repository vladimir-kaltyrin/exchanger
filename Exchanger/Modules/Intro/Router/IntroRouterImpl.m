#import "IntroRouterImpl.h"
#import "AssembledViewController.h"
#import "SafeBlocks.h"

@implementation IntroRouterImpl

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure {
    
    id<ExchangeMoneyAssembly> assembly = [self.assemblyFactory exchangeMoneyAssembly];
    AssembledViewController *assembledViewController = [assembly module];
    
    block(configure, assembledViewController.module);
    
    [self popWithNavigationController:assembledViewController.viewController animated:YES completion:nil];
}

@end
