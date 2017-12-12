#import "CarouselPageData.h"

@implementation CarouselPageData
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                                input:(NSString *)input
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate
                       remainderStyle:(CarouselPageRemainderStyle)remainderStyle
                       inputFormatter:(nonnull TextFieldAttributedStringFormatter)inputFormatter
                         onTextChange:(nonnull OnTextChange)onTextChange
{
    if (self = [super init]) {
        _currencyTitle = currencyTitle;
        _input = input;
        _remainder = remainder;
        _rate = rate;
        _remainderStyle = remainderStyle;
        _inputFormatter = inputFormatter;
        _onTextChange = onTextChange;
    }
    return self;
}

@end
