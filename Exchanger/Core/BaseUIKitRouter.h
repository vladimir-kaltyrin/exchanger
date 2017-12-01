#import <UIKit/UIKit.h>

@interface BaseUIKitRouter : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)dismissCurrentModule:(BOOL)animated;

- (void)dismissCurrentModule;

- (void)push: (UIViewController *)viewController animated:(BOOL)animated;

- (void)pop: (UIViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion;

- (void)popWithNavigationController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion;

@end
