#import "NumbersFormatterImpl.h"

@implementation NumbersFormatterImpl

- (NSString *)format:(NSString *)string {
    
    NSMutableCharacterSet *set = [NSMutableCharacterSet decimalDigitCharacterSet];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    [set addCharactersInString:separator];
    [set invert];
    
    NSString *trimmedString = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    
    NSArray *components = [trimmedString componentsSeparatedByString:separator];
    if (components.count > 2) {
        NSInteger index = [trimmedString rangeOfString:separator].location;
        NSRange range = NSMakeRange(index + 1, trimmedString.length - index - 1);
        trimmedString = [trimmedString stringByReplacingOccurrencesOfString:separator
                                                                 withString:@""
                                                                    options:0
                                                                      range:range];
    }
    
    if ([trimmedString isEqualToString:separator]) {
        return @"";
    }
    
    return trimmedString;
}

@end
