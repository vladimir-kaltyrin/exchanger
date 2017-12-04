#import <UIKit/UIKit.h>

@interface ObservableTextField : UIView
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, strong) BOOL(^onTextChange)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

@end
