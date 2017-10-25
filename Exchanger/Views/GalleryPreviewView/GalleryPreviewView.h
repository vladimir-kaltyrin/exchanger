#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewView : UIView
@property (nonatomic, strong) void(^onSelect)(BOOL);
@property (nonatomic, strong, nullable) void(^onPageChange)(NSInteger current, NSInteger total);
@end

NS_ASSUME_NONNULL_END
