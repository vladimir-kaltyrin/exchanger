#import <Foundation/Foundation.h>
#import "BalanceFormatter.h"

typedef struct _FormattedString {
    __unsafe_unretained NSString *primary;
    __unsafe_unretained NSString *secondary;
} FormattedString;


NS_INLINE FormattedString MakeFormattedString(NSString *primary, NSString *secondary) {
    FormattedString formattedString;
    formattedString.primary = primary;
    formattedString.secondary = secondary;
    return formattedString;
}

@implementation BalanceFormatter

- (NSString *)formatBalance:(NSNumber *)balance {
    switch (self.style) {
        case BalanceFormatterStyleHundredths:
            return [NSString stringWithFormat:@"%.03f", balance.floatValue];
            break;
        case BalanceFormatterStyleTenThousandths:
            return [NSString stringWithFormat:@"%.04f", balance.floatValue];
            break;
    }
}

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    FormattedString formattedString = [self formattedStringWithBalance:balance];
    
    if (formattedString.primary == nil) {
        return nil;
    }

    if (formattedString.secondary == nil) {
        return [[NSAttributedString alloc] initWithString:formattedString.primary
                                               attributes:self.primaryPartStyle.attributes];
    }
    
    NSAttributedString *primaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.primary
                                                                                  attributes:self.primaryPartStyle.attributes];
    [string appendAttributedString:primaryAttributedString];
    
    NSAttributedString *secondaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.secondary
                                                                                    attributes:self.primaryPartStyle.attributes];
    
    [string appendAttributedString:secondaryAttributedString];
    
    return string;
}

// MARK: - Private

- (FormattedString)formattedStringWithBalance:(NSString *)balance {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    FormattedString result;
    
    switch (self.style) {
        case BalanceFormatterStyleHundredths:
        {
            NSArray *components = [balance componentsSeparatedByString:separator];
            result = MakeFormattedString(components.firstObject, components.lastObject);
        }
            break;
        case BalanceFormatterStyleTenThousandths:
        {
            NSInteger location = [balance rangeOfString:separator].location + 2;
            NSString *primaryString = [balance substringToIndex:location];
            NSString *secondaryString = [balance substringFromIndex:location];
            result = MakeFormattedString(primaryString, secondaryString);
        }
            break;
    }
    
    return result;
}

@end
