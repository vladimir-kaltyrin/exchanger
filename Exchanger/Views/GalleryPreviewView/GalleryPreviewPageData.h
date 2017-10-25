#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageData : NSObject
    
@property (nonatomic, strong, readonly, nullable) UIImage *placeholder;
@property (nonatomic, strong, readonly) NSString *imageUrl;
@property (nonatomic, strong, readonly) NSString *currencyTitle;
@property (nonatomic, strong, readonly) NSString *currencyAmount;
@property (nonatomic, strong, readonly) NSString *remainder;
@property (nonatomic, strong, readonly) NSString *rate;
    
- (instancetype)initWithPlaceholder:(nullable UIImage *)placeholder
                           imageUrl:(NSString *)imageUrl
                      currencyTitle:(NSString *)currencyTitle
                     currencyAmount:(NSString *)currencyAmount
                          remainder:(NSString *)remainder
                               rate:(NSString *)rate;
    
@end

NS_ASSUME_NONNULL_END
