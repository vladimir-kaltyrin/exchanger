#import <UIKit/UIKit.h>

@interface IntroView : UIView
@property (nonatomic, strong) void(^onStartTap)();
@property (nonatomic, strong) void(^onResetTap)();

- (void)setTitle:(NSString *)title;
- (void)setResetButtonTitle:(NSString *)resetButtonTitle;
- (void)setStartButtonTitle:(NSString *)startButtonTitle;

@end
