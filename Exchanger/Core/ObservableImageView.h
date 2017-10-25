#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObservableImageView : UIImageView
@property (nonatomic, strong, nullable) void(^onImageChange)(UIImage *nullable);
@end

NS_ASSUME_NONNULL_END
