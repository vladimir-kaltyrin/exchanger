#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"

@protocol IntroViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong) void(^onStartTap)();
@property (nonatomic, strong) void(^onResetTap)();

- (void)setTitle:(NSString *)title;

- (void)setResetButtonTitle:(NSString *)resetButtonTitle;
- (void)setStartButtonTitle:(NSString *)startButtonTitle;

@end
