#import <Foundation/Foundation.h>
#import "BalanceFormatterImpl.h"

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

@interface BalanceFormatterImpl()
@property (nonatomic, strong) AttributedStringStyle *primaryPartStyle;
@property (nonatomic, strong) AttributedStringStyle *secondaryPartStyle;
@property (nonatomic, assign) BalanceFormatterStyle formatterStyle;
@end

@implementation BalanceFormatterImpl

// MARK: - Init

- (instancetype)initWithPrimaryPartStyle:(AttributedStringStyle *)primaryPartStyle
                      secondaryPartStyle:(AttributedStringStyle *)secondaryPartStyle
                          formatterStyle:(BalanceFormatterStyle)formatterStyle
{
    self = [super init];
    if (self) {
        self.primaryPartStyle = primaryPartStyle;
        self.secondaryPartStyle = secondaryPartStyle;
        self.formatterStyle = formatterStyle;
    }
    return self;
}

// MARK: - Public

- (NSString *)formatBalance:(NSString *)balance {
    
    NSNumber *number = @(balance.floatValue);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

    switch (self.formatterStyle) {
        case BalanceFormatterStyleHundredths:
            numberFormatter.maximumFractionDigits = 2;
            break;
        case BalanceFormatterStyleTenThousandths:
            numberFormatter.maximumFractionDigits = 4;
            break;
    }
    
    NSString *formattedBalance = [numberFormatter stringFromNumber:number];;
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    if ([balance rangeOfString:separator].location != NSNotFound) {
        return [NSString stringWithFormat:@"%@%@", formattedBalance, separator];
    } else {
        return formattedBalance;
    }
}

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    FormattedString formattedString = [self formattedStringWithBalance:balance];
    
    if (formattedString.primary != nil) {
        NSAttributedString *primaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.primary
                                                                                      attributes:self.primaryPartStyle.attributes];
        [string appendAttributedString:primaryAttributedString];
    }
    
    if (formattedString.secondary != nil) {
        NSAttributedString *secondaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.secondary
                                                                                        attributes:self.secondaryPartStyle.attributes];
        
        [string appendAttributedString:secondaryAttributedString];
    }
    
    return string;
}

// MARK: - Private

- (FormattedString)formattedStringWithBalance:(NSString *)balance {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    FormattedString result;
    
    switch (self.formatterStyle) {
        case BalanceFormatterStyleHundredths:
        {
            NSArray *components = [balance componentsSeparatedByString:separator];
            if (components.count == 0) {
                result = MakeFormattedString(nil, nil);
                break;
            }
            
            NSString *primaryString;
            NSString *secondaryString;
            if (components.count > 1) {
                primaryString = [NSString stringWithFormat:@"%@%@", components.firstObject, separator];
                secondaryString = components[1];
            } else {
                primaryString = components.firstObject;
            }
            result = MakeFormattedString(primaryString, secondaryString);
        }
            break;
        case BalanceFormatterStyleTenThousandths:
        {
            NSInteger location = [balance rangeOfString:separator].location + 3;
            NSString *primaryString = [balance substringToIndex:location];
            NSString *secondaryString = [balance substringFromIndex:location + 1];
            result = MakeFormattedString(primaryString, secondaryString);
        }
            break;
    }
    
    return result;
}

@end
