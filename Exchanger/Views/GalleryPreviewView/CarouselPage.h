#import <UIKit/UIKit.h>

@class CarouselPageData;

NS_ASSUME_NONNULL_BEGIN

@interface CarouselPage : UIView
@property (nonatomic, strong) void(^onFocus)();

- (instancetype)init __attribute__((unavailable("init not available")));
    
- (void)setViewData:(CarouselPageData *)data;

- (void)focus;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
