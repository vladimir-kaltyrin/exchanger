#import "IntroRouterImpl.h"
#import "AssembledViewController.h"
#import "ConvenientObjC.h"

@implementation IntroRouterImpl

- (void)showAbout {
    
    let url = [NSURL URLWithString:@"https://github.com/vkaltyrin/exchanger"];
    
    [[UIApplication sharedApplication] openURL:url];
}

- (void)showDemoWith:(void (^)(id<ExchangeMoneyModule>))configure {
    
    let assembly = [self.assemblyFactory exchangeMoneyAssembly];
    let assembledViewController = [assembly module];
    
    safeBlock(configure, assembledViewController.module);
    
    [self presentWithNavigationController:assembledViewController.viewController
                                 animated:YES
                               completion:nil];
}

@end
