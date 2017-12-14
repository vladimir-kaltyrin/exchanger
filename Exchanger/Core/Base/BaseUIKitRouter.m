#import "ConvenientObjC.h"
#import "BaseUIKitRouter.h"

@interface BaseUIKitRouter()
@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation BaseUIKitRouter

// MARK: - Init

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

// MARK: - Public

- (void)dismissCurrentModule:(BOOL)animated {
    if (self.viewController == nil) {
        return;
    }
    
    if (self.viewController.navigationController != nil) {
        let navigationController = self.viewController.navigationController;
        let index = [navigationController.viewControllers indexOfObject:self.viewController];
        if (index > 0) {
            let previousViewController = navigationController.viewControllers[index - 1];
            [navigationController popToViewController:previousViewController animated:animated];
        } else {
            [navigationController.presentingViewController dismissViewControllerAnimated:animated
                                                                              completion:nil];
        }
    } else {
        [self.viewController.presentingViewController dismissViewControllerAnimated:animated
                                                                         completion:nil];
    }
}

- (void)dismissCurrentModule {
    return [self dismissCurrentModule:YES];
}

- (void)push: (UIViewController *)viewController
    animated:(BOOL)animated
{
    [self.viewController.navigationController
     pushViewController:viewController
     animated:animated];
}

- (void)present: (UIViewController *)viewController
       animated:(BOOL)animated
     completion:(void(^)())completion
{
    [self.viewController presentViewController:viewController
                                      animated:animated
                                    completion:completion];
}

- (void)presentWithNavigationController:(UIViewController *)viewController
                               animated:(BOOL)animated
                             completion:(void(^)())completion
{
    let navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self present:navigationController
         animated:animated
       completion:completion];
}

@end
