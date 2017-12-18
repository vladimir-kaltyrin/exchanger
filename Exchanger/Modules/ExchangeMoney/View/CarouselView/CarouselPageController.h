#import <UIKit/UIKit.h>

@class CarouselPageData;

NS_ASSUME_NONNULL_BEGIN

@interface CarouselPageController : UIViewController
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
@property (nonatomic, strong, nullable) BOOL(^checkCanFocus)();
@property (nonatomic, strong, nullable) void(^onViewDidAppear)();
@property (nonatomic, strong) void(^onFocus)();

- (instancetype)init __attribute__((unavailable("init not available")));
    
- (instancetype)initWithIndex:(NSInteger)index data:(CarouselPageData *)data;

- (void)focus;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
