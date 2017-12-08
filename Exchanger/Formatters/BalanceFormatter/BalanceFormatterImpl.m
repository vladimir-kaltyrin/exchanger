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
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
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
        
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.minimumIntegerDigits = 1;
    }
    return self;
}

// MARK: - Public

- (NSString *)formatBalance:(NSString *)balance {
    
    NSNumber *number = @(balance.floatValue);

    switch (self.formatterStyle) {
        case BalanceFormatterStyleHundredths:
            self.numberFormatter.maximumFractionDigits = 2;
            break;
        case BalanceFormatterStyleTenThousandths:
            self.numberFormatter.maximumFractionDigits = 6;
            break;
    }
    
    NSString *formattedBalance = [self.numberFormatter stringFromNumber:number];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    return formattedBalance;
}

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance {
    
    NSString *formattedBalance = [self formatBalance:balance];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    FormattedString formattedString = [self formattedStringWithBalance:formattedBalance];
    
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
    
    NSArray *components = [balance componentsSeparatedByString:separator];
    if (components.count == 0) {
        return MakeFormattedString(nil, nil);
    }
    
    if (components.count == 1) {
        return MakeFormattedString(components.firstObject, nil);
    }
    
    switch (self.formatterStyle) {
        case BalanceFormatterStyleHundredths:
        {
            NSString *primaryString = [NSString stringWithFormat:@"%@%@", components.firstObject, separator];
            NSString *secondaryString = secondaryString = components[1];
            
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
