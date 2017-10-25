#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^OnBarButtonTap)();

@interface BarButton : NSObject
@property (nonatomic, strong, readonly) UIBarButtonItem *barButtonItem;
@property (nonatomic, strong) OnBarButtonTap onBarButtonTap;
@property (nonatomic, assign) BOOL enabled;

- (instancetype)initWithTitle:(NSString *)title;

@end
