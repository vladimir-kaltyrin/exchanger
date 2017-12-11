#import <UIKit/UIKit.h>

@class GalleryPreviewPageData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPage : UIView
    
- (void)setViewData:(GalleryPreviewPageData *)data;

- (void)focus;
    
- (void)prepareForReuse;
    
@end

NS_ASSUME_NONNULL_END
