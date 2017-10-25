#import "GalleryPreviewPageData.h"

@implementation GalleryPreviewPageData
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                       currencyAmount:(NSString *)currencyAmount
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate {
    if (self = [super init]) {
        _currencyTitle = currencyTitle;
        _currencyAmount = currencyAmount;
        _remainder = remainder;
        _rate = rate;
    }
    return self;
}

@end
