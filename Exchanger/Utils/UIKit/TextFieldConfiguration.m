#import "ConvenientObjC.h"
#import "TextFieldConfiguration.h"

@implementation TextFieldConfiguration

+ (TextFieldConfiguration *)inputConfiguration {
    
    var configuration = [[TextFieldConfiguration alloc] init];
    configuration.font = [UIFont systemFontOfSize:34.0];
    configuration.textColor = [UIColor whiteColor];
    configuration.tintColor = [UIColor redColor];
    configuration.textAlignment = NSTextAlignmentRight;
    configuration.keyboardType = UIKeyboardTypeDecimalPad;
    configuration.adjustsFontSizeToFitWidth = YES;
    
    return configuration;
    
}

@end
