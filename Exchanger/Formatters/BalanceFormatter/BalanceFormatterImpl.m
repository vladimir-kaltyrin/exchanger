#import "ConvenientObjC.h"
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
        self.numberFormatter.roundingMode = NSNumberFormatterRoundDown;
        
        switch (self.formatterStyle) {
            case BalanceFormatterStyleHundredths:
                self.numberFormatter.maximumFractionDigits = 2;
                break;
            case BalanceFormatterStyleTenThousandths:
                self.numberFormatter.maximumFractionDigits = 6;
                break;
        }
    }
    return self;
}

// MARK: - Public

- (FormatterResultData *)formatNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign {
    let string = [self.numberFormatter stringFromNumber:number];
    
    return [self formatString:string sign:sign];
}

- (FormatterResultData *)formatString:(NSString *)balance sign:(BalanceFormatterSign)sign {
    
    let formattedString = [self attributedFormatBalance:balance sign:sign];
    
    NSString *newBalance;
    let parseData = [self parseBalance:balance sign:sign];
    switch (parseData.parsingResult) {
        case ParsingResultZero:
        case ParsingResultInteger:
            newBalance = [self applySign:sign text:balance];
            break;
        case ParsingResultFloat:
            newBalance = [self formatBalance:balance sign:sign];
            break;
    }
    
    let number = [self.numberFormatter numberFromString:newBalance];
    
    return [[FormatterResultData alloc] initWithFormattedString:formattedString
                                                         string:newBalance
                                                         number:number];
}

// MARK: - Private

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance sign:(BalanceFormatterSign)sign {
    
    var string = [[NSMutableAttributedString alloc] init];
    
    let formattedString = [self formattedStringWithBalance:balance sign:sign];
    
    if (formattedString.primaryString != nil) {
        let primaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.primaryString
                                                                      attributes:self.primaryPartStyle.attributes];
        [string appendAttributedString:primaryAttributedString];
    }
    
    if (formattedString.secondaryString != nil) {
        let secondaryAttributedString = [[NSAttributedString alloc] initWithString:formattedString.secondaryString
                                                                        attributes:self.secondaryPartStyle.attributes];
        
        [string appendAttributedString:secondaryAttributedString];
    }
    
    return string;
}

- (NSString *)formatBalance:(NSString *)balance sign:(BalanceFormatterSign)sign {
    
    let number = [self.numberFormatter numberFromString:balance];
    var formattedBalance = [self.numberFormatter stringFromNumber:number];
    formattedBalance = [self applySign:sign text:formattedBalance];
    
    return formattedBalance;
}

- (NSString *)applySign:(BalanceFormatterSign)sign text:(NSString *)text {
    
    if (text.floatValue != 0) {
        switch (sign) {
            case BalanceFormatterSignPlus:
                return [NSString stringWithFormat:@"+%@", text];
                break;
            case BalanceFormatterSignMinus:
                return [NSString stringWithFormat:@"-%@", text];
                break;
            case BalanceFormatterSignNone:
                break;
        }
    }
    return text;
}

- (BalanceParseData *)parseBalance:(NSString *)balance sign:(BalanceFormatterSign)sign {
    let locale = [NSLocale currentLocale];
    let separator = (NSString *)[locale objectForKey:NSLocaleDecimalSeparator];
    
    let formattedBalance = [self formatBalance:balance sign:sign];
    
    ParsingResult result;
    let components = [formattedBalance componentsSeparatedByString:separator];
    if (components.count == 0) {
        result = ParsingResultZero;
    } else if (components.count == 1) {
        result = ParsingResultInteger;
    } else {
        result = ParsingResultFloat;
    }
    
    var data = [[BalanceParseData alloc] init];
    data.parsingResult = result;
    data.components = components;
    
    return data;
}

- (FormattedStringData *)formattedStringWithBalance:(NSString *)balance sign:(BalanceFormatterSign)sign {
    let data = [self parseBalance:balance sign:sign];
    
    var formattedString = [[FormattedStringData alloc] init];
    
    switch (data.parsingResult) {
        case ParsingResultZero:
        {
            formattedString.primaryString = nil;
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultInteger:
        {
            formattedString.primaryString = [self applySign:sign text:balance];
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultFloat:
        {
            let components = data.components;
            
            let locale = [NSLocale currentLocale];
            let separator = (NSString *)[locale objectForKey:NSLocaleDecimalSeparator];
            
            NSString *primaryString;
            NSString *secondaryString;
            
            switch (self.formatterStyle) {
                case BalanceFormatterStyleHundredths:
                {
                    primaryString = [NSString stringWithFormat:@"%@%@", components.firstObject, separator];
                    secondaryString = components[1];
                }
                    break;
                case BalanceFormatterStyleTenThousandths:
                {
                    let location = [balance rangeOfString:separator].location + 3;
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
