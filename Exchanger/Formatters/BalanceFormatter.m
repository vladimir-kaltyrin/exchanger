#import <Foundation/Foundation.h>
#import "BalanceFormatter.h"

@implementation BalanceFormatter

- (NSString *)formatBalance:(NSNumber *)balance {
    
    return [NSString stringWithFormat:@"%.02f", balance.floatValue];
}

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    NSArray *components;
    switch (self.style) {
        case BalanceFormatterStyleHundredths:
            components = [balance componentsSeparatedByString:separator];
            break;
        case BalanceFormatterStyleTenThousandths:
        {
            NSInteger location = [balance rangeOfString:@"."].location + 2;
            NSString *primaryString = [balance substringToIndex:location];
            NSString *secondaryString = [balance substringFromIndex:location];
            components = @[primaryString, secondaryString];
        }
            break;
    }
    
    if (components.count == 0) {
        return nil;
    }
    
    if ((components.count <= 1) && (components.count > 0)) {
        return [[NSAttributedString alloc] initWithString:components.firstObject
                                               attributes:self.primaryPartStyle.attributes];
    }
    
    NSString *primaryString = components.firstObject;
    NSAttributedString *primaryAttributedString = [[NSAttributedString alloc] initWithString:primaryString
                                                                                  attributes:self.primaryPartStyle.attributes];
    [string appendAttributedString:primaryAttributedString];
    
    NSString *secondaryString = components[1];
    NSAttributedString *secondaryAttributedString = [[NSAttributedString alloc] initWithString:secondaryString
                                                                                    attributes:self.primaryPartStyle.attributes];
    
    [string appendAttributedString:secondaryAttributedString];
    
    return string;
}

@end
