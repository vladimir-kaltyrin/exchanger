#import <UIKit/UIKit.h>

@class GalleryPreviewPageData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageController : UIViewController
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
    
- (instancetype)initWithIndex:(NSInteger)index data:(GalleryPreviewPageData *)data;

- (void)focus;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
