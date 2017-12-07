#import "GalleryPreviewPageData.h"

@implementation GalleryPreviewPageData
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                       currencyAmount:(NSString *)currencyAmount
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate
                       remainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle
{
    if (self = [super init]) {
        _currencyTitle = currencyTitle;
        _currencyAmount = currencyAmount;
        _remainder = remainder;
        _rate = rate;
        _remainderStyle = remainderStyle;
    }
    return self;
}

@end
