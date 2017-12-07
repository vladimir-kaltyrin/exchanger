#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GalleryPreviewPageRemainderStyle) {
    GalleryPreviewPageRemainderStyleNormal,
    GalleryPreviewPageRemainderStyleDeficiency
};

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageData : NSObject

@property (nonatomic, strong, readonly) NSString *currencyTitle;
@property (nonatomic, strong, readonly) NSAttributedString *currencyAmount;
@property (nonatomic, strong, readonly) NSString *remainder;
@property (nonatomic, strong, readonly) NSString *rate;
@property (nonatomic, assign, readonly) GalleryPreviewPageRemainderStyle remainderStyle;
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                       currencyAmount:(NSAttributedString *)currencyAmount
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate
                       remainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle;
    
@end

NS_ASSUME_NONNULL_END
