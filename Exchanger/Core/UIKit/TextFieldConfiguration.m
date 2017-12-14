#import "TextFieldConfiguration.h"

@implementation TextFieldConfiguration

+ (TextFieldConfiguration *)inputConfiguration {
    
    TextFieldConfiguration *configuration = [[TextFieldConfiguration alloc] init];
    configuration.font = [UIFont systemFontOfSize:34.0];
    configuration.textColor = [UIColor whiteColor];
    configuration.tintColor = [UIColor redColor];
    configuration.textAlignment = NSTextAlignmentRight;
    configuration.keyboardType = UIKeyboardTypeDecimalPad;
    
    return configuration;
    
}

@end
