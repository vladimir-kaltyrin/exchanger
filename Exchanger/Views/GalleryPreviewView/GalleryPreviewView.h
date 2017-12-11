#import <UIKit/UIKit.h>
#import "GalleryPreviewData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewView : UIView
@property (nonatomic, strong) void(^onSelect)(BOOL);
@property (nonatomic, strong, nullable) void(^onPageChange)(NSInteger current);
    
- (void)setViewData:(GalleryPreviewData *)data;

- (void)focus;
    
@end

NS_ASSUME_NONNULL_END
