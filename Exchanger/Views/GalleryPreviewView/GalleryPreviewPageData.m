#import "GalleryPreviewPageData.h"

@implementation GalleryPreviewPageData
    
- (instancetype)initWithPlaceholder:(nullable UIImage *)placeholder
                           imageUrl:(NSString *)imageUrl
                      currencyTitle:(NSString *)currencyTitle
                     currencyAmount:(NSString *)currencyAmount
                          remainder:(NSString *)remainder
                               rate:(NSString *)rate; {
    if (self = [super init]) {
        _placeholder = placeholder;
        _imageUrl = imageUrl;
        _currencyTitle = currencyTitle;
        _currencyAmount = currencyAmount;
        _remainder = remainder;
        _rate = rate;
    }
    return self;
}

@end
