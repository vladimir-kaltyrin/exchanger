#import <Foundation/Foundation.h>
#import "BalanceFormatterImpl.h"
#import "BalanceParseData.h"

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

- (FormatterResultData *)format:(NSString *)balance {
    NSAttributedString *formattedString = [self attributedFormatBalance:balance];
    
    NSString *newBalance;
    BalanceParseData *parseData = [self parseBalance:balance];
    switch (parseData.parsingResult) {
        case ParsingResultZero:
        case ParsingResultInteger:
            newBalance = balance;
            break;
        case ParsingResultFloat:
            newBalance = [self formatBalance:balance];
            break;
    }
    
    return [[FormatterResultData alloc] initWithFormattedString:formattedString string:newBalance];
}

// MARK: - Private

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
    
    return formattedBalance;
}

- (BalanceParseData *)parseBalance:(NSString *)balance {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
    
    NSString *formattedBalance = [self formatBalance:balance];
    
    ParsingResult result;
    NSArray *components = [formattedBalance componentsSeparatedByString:separator];
    if (components.count == 0) {
        result = ParsingResultZero;
    } else if (components.count == 1) {
        result = ParsingResultInteger;
    } else {
        result = ParsingResultFloat;
    }
    
    BalanceParseData *data = [[BalanceParseData alloc] init];
    data.parsingResult = result;
    data.components = components;
    
    return data;
}

- (FormattedString)formattedStringWithBalance:(NSString *)balance {
    BalanceParseData *data = [self parseBalance:balance];
    
    switch (data.parsingResult) {
        case ParsingResultZero:
            return MakeFormattedString(nil, nil);
        case ParsingResultInteger:
            return MakeFormattedString(balance, nil);
        case ParsingResultFloat:
        {
            NSArray *components = data.components;
            FormattedString result;
            
            NSLocale *locale = [NSLocale currentLocale];
            NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
            
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
            break;
    }
}

@end
