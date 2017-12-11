#import <UIKit/UIKit.h>

@class GalleryPreviewPageData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPage : UIView
@property (nonatomic, strong) void(^onFocus)();

- (instancetype)init __attribute__((unavailable("init not available")));
    
- (void)setViewData:(GalleryPreviewPageData *)data;

- (void)focus;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
