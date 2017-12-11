#import <UIKit/UIKit.h>

@interface UIView (Debug)

- (UIView *)findViewThatIsFirstResponder;

+ (UIView *)firstResponderInWindow;

@end
