#import <UIKit/UIKit.h>

@class GalleryPreviewPageData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewController : UIPageViewController
    
@property (nonatomic, strong, nullable) void(^onPageChange)(NSInteger current, NSInteger total);
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
    
- (void)setData:(NSArray<GalleryPreviewPageData *> *)data currentPage:(NSInteger)currentPage;
    
- (void)prepareForReuse;

@end

NS_ASSUME_NONNULL_END
