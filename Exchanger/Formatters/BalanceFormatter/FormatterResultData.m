#import "FormatterResultData.h"

@implementation FormatterResultData

- (instancetype)initWithFormattedString:(NSAttributedString *)formattedString string:(NSString *)string {
    self = [super init];
    if (self) {
        _formattedString = formattedString;
        _string = string;
    }
    return self;
}

@end
