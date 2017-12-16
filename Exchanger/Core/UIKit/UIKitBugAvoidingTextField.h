#import <UIKit/UIKit.h>

// There are side effects in UIKit related to performing animation on becomeFirstResponder and resignFirstResponder.
// In case of quick switching between first responders this behaviour leads to animation defect when cursor jumps sometimes.

@interface UIKitBugAvoidingTextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

@end
