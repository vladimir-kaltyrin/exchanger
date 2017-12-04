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

- (NSString *)formatBalance:(NSNumber *)balance {
    switch (self.formatterStyle) {
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
                                                                                    attributes:self.secondaryPartStyle.attributes];
    
    [string appendAttributedString:secondaryAttributedString];
    
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
