#import "NumbersFormatterImpl.h"

@implementation NumbersFormatterImpl

// MARK: - NumbersFormatter

- (NSString *)format:(NSString *)string {
    NSString *result = [self filterNonNumericAndSeparatorCharacters:string];
    result = [self filterExtraSeparators:result];
    result = [self filterStringEqualToSeparator:result];
    result = [self filterLeadingZeros:result];
    
    return result;
}

// MARK: - Private

- (NSString *)separator {
    NSLocale *locale = [NSLocale currentLocale];
    return [locale objectForKey:NSLocaleDecimalSeparator];
}

- (NSString *)filterNonNumericAndSeparatorCharacters:(NSString *)targetString {
    NSMutableCharacterSet *set = [NSMutableCharacterSet decimalDigitCharacterSet];
    
    NSString *separator = [self separator];
    
    [set addCharactersInString:separator];
    [set invert];
    
    return [[targetString componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}

- (NSString *)filterExtraSeparators:(NSString *)targetString {
    NSString *separator = [self separator];
    NSArray *components = [targetString componentsSeparatedByString:separator];
    if (components.count > 2) {
        NSInteger index = [targetString rangeOfString:separator].location;
        NSRange range = NSMakeRange(index + 1, targetString.length - index - 1);
        return [targetString stringByReplacingOccurrencesOfString:separator
                                                                 withString:@""
                                                                    options:0
                                                                      range:range];
    }
    return targetString;
}

- (NSString *)filterStringEqualToSeparator:(NSString *)targetString {
    NSString *separator = [self separator];
    if ([targetString isEqualToString:separator]) {
        return @"";
    }
    return targetString;
}

- (NSString *)filterLeadingZeros:(NSString *)targetString {
    NSRange range = [targetString rangeOfString:@"^0*" options:NSRegularExpressionSearch];
    return [targetString stringByReplacingCharactersInRange:range withString:@""];
}

@end
