#import <UIKit/UIKit.h>

@class GalleryPreviewPageData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageController : UIViewController
@property (nonatomic, assign, readonly) NSInteger index;
    
- (instancetype)initWithIndex:(NSInteger)index data:(GalleryPreviewPageData *)data;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
