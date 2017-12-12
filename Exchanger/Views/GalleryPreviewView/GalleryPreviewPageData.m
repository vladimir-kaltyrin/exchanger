#import "GalleryPreviewPageData.h"

@implementation GalleryPreviewPageData
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                                input:(NSString *)input
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate
                       remainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle
{
    if (self = [super init]) {
        _currencyTitle = currencyTitle;
        _input = input;
        _remainder = remainder;
        _rate = rate;
        _remainderStyle = remainderStyle;
    }
    return self;
}

@end
