#import "NumbersFormatterImpl.h"

@implementation NumbersFormatterImpl

- (NSString *)format:(NSString *)string {
    
    NSMutableCharacterSet *set = [NSMutableCharacterSet decimalDigitCharacterSet];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    [set addCharactersInString:separator];
    
    return [string stringByTrimmingCharactersInSet:[set invertedSet]];
}

@end
