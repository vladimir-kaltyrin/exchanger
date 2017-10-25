#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)

- (UIEdgeInsets)defaultContentInsets {
    return UIEdgeInsetsMake([self.topLayoutGuide length], 0, 0, 0);
}

@end
