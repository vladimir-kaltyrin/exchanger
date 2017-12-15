#import "CarouselPageData.h"

@implementation CarouselPageData
    
- (instancetype)initWithAccessibilityId:(NSString *)accessibilityId
                          currencyTitle:(NSString *)currencyTitle
                                  input:(NSAttributedString *)input
                              remainder:(NSString *)remainder
                                   rate:(NSString *)rate
                         remainderStyle:(CarouselPageRemainderStyle)remainderStyle
                           onTextChange:(nonnull OnTextChange)onTextChange
{
    if (self = [super init]) {
        _accessibilityId = accessibilityId;
        _currencyTitle = currencyTitle;
        _input = input;
        _remainder = remainder;
        _rate = rate;
        _remainderStyle = remainderStyle;
        _onTextChange = onTextChange;
    }
    return self;
}

@end
