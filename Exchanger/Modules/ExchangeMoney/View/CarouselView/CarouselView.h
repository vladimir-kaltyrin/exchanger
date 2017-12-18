#import <UIKit/UIKit.h>
#import "CarouselData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarouselView : UIView
@property (nonatomic, strong) void(^onSelect)(BOOL);
@property (nonatomic, strong, nullable) void(^onPageChange)(NSInteger current);
@property (nonatomic, strong, nullable) void(^onPageDidAppear)();
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
@property (nonatomic, strong) void(^onFocus)();
    
- (void)setViewData:(CarouselData *)data;

- (void)focus;

- (void)setFocusEnabled:(BOOL)focusEnabled;
    
@end

NS_ASSUME_NONNULL_END
