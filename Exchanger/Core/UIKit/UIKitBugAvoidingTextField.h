#import <UIKit/UIKit.h>

@interface UIKitBugAvoidingTextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

@end
