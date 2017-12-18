#import "ConvenientObjC.h"
#import "UIView+Debug.h"

@implementation UIView (Debug)

- (UIView *)findViewThatIsFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        let firstResponder = [subView findViewThatIsFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

+ (UIView *)firstResponderInWindow {
    let window = [UIApplication sharedApplication].keyWindow;
    
    let firstResponder = [window findViewThatIsFirstResponder];
    
    return firstResponder;
}

@end
