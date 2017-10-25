#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageData : NSObject
    
@property (nonatomic, strong, readonly, nullable) UIImage *placeholder;
@property (nonatomic, strong, readonly) NSString *imageUrl;
    
- (instancetype)initWithPlaceholder:(nullable UIImage *)placeholder imageUrl:(NSString *)imageUrl;
    
@end

NS_ASSUME_NONNULL_END
