#import <Foundation/Foundation.h>
#import "BalanceFormatterImpl.h"
#import "BalanceParseData.h"
#import "FormattedStringData.h"

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
    
    FormattedStringData *formattedString = [self formattedStringWithBalance:balance];
    
    if (formattedString.primaryString != nil) {
        NSAttributedString *primaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.primaryString
                                                                                      attributes:self.primaryPartStyle.attributes];
        [string appendAttributedString:primaryAttributedString];
    }
    
    if (formattedString.secondaryString != nil) {
        NSAttributedString *secondaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.secondaryString
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

- (FormattedStringData *)formattedStringWithBalance:(NSString *)balance {
    BalanceParseData *data = [self parseBalance:balance];
    
    FormattedStringData *formattedString = [[FormattedStringData alloc] init];
    
    switch (data.parsingResult) {
        case ParsingResultZero:
        {
            formattedString.primaryString = nil;
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultInteger:
        {
            formattedString.primaryString = balance;
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultFloat:
        {
            NSArray *components = data.components;
            
            NSLocale *locale = [NSLocale currentLocale];
            NSString *separator = [locale objectForKey:NSLocaleDecimalSeparator];
            
            NSString *primaryString;
            NSString *secondaryString;
            
            switch (self.formatterStyle) {
                case BalanceFormatterStyleHundredths:
                {
                    primaryString = [NSString stringWithFormat:@"%@%@", components.firstObject, separator];
                    secondaryString = secondaryString = components[1];
                }
                    break;
                case BalanceFormatterStyleTenThousandths:
                {
                    NSInteger location = [balance rangeOfString:separator].location + 3;
                    primaryString = [balance substringToIndex:location];
                    secondaryString = [balance substringFromIndex:location + 1];
                }
                    break;
            }
            
            formattedString.primaryString = primaryString;
            formattedString.secondaryString = secondaryString;
        }
            break;
    }
    
    return formattedString;
}

@end
