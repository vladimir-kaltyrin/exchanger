#import "UIView+Debug.h"

@implementation UIView (Debug)

- (UIView *)findViewThatIsFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findViewThatIsFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

+ (UIView *)firstResponderInWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *firstResponder = [window findViewThatIsFirstResponder];
    
    return firstResponder;
}

@end
