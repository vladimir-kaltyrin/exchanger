#import "ConvenientObjC.h"
#import "FormatterData.h"
#import "FormatterFactoryImpl.h"

@implementation FormatterData

- (instancetype)initWithFormattedString:(NSAttributedString *)formattedString
                                 string:(NSString *)string
                                 number:(NSNumber *)number
{
    self = [super init];
    if (self) {
        _formattedString = formattedString;
        _string = string;
        _number = number;
    }
    return self;
}

- (float)floatValue {
    return self.number.floatValue;
}

+ (FormatterData *)formatterDataWithString:(NSString *)string {
    return [FormatterData formatterDataWithString:string sign:BalanceFormatterSignNone];
}

+ (FormatterData *)formatterDataWithString:(NSString *)string sign:(BalanceFormatterSign)sign {
    let formatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
    return [formatter formatString:string sign:sign];
}

+ (FormatterData *)formatterDataWithNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign {
    let formatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
    return [formatter formatNumber:number sign:sign];
}

@end
