#import "AssembledViewController.h"

@implementation AssembledViewController

- (instancetype)initWithViewController:(UIViewController *)viewController
                                module:(id)module
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.module = module;
    }
    
    return self;
}

@end
