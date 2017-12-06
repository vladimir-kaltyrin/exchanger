#import <UIKit/UIKit.h>

@class GalleryPreviewData;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewView : UIView
@property (nonatomic, strong) void(^onSelect)(BOOL);
@property (nonatomic, strong, nullable) void(^onPageChange)(NSInteger current);
    
- (void)setViewData:(GalleryPreviewData *)data;
    
@end

NS_ASSUME_NONNULL_END
