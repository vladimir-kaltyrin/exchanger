#import "IntroRouterImpl.h"
#import "AssembledViewController.h"
#import "SafeBlocks.h"

@implementation IntroRouterImpl

- (void)showAbout {
    
    NSURL *url = [NSURL URLWithString:@"https://github.com/vkaltyrin/exchanger"];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure {
    
    id<ExchangeMoneyAssembly> assembly = [self.assemblyFactory exchangeMoneyAssembly];
    AssembledViewController *assembledViewController = [assembly module];
    
    block(configure, assembledViewController.module);
    
    [self presentWithNavigationController:assembledViewController.viewController animated:YES completion:nil];
}

@end
