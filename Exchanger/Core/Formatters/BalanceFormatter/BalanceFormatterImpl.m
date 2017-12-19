#import "ConvenientObjC.h"
#import <Foundation/Foundation.h>
#import "BalanceFormatterImpl.h"
#import "BalanceParseData.h"
#import "FormattedStringData.h"
#import "NumbersFormatter.h"

@interface BalanceFormatterImpl()
@property (nonatomic, strong) AttributedStringStyle *primaryPartStyle;
@property (nonatomic, strong) AttributedStringStyle *secondaryPartStyle;
@property (nonatomic, assign) BalanceFormatterStyle formatterStyle;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) id<NumbersFormatter> numberFilterFormatter;
@end

@implementation BalanceFormatterImpl

// MARK: - Init

- (instancetype)initWithPrimaryPartStyle:(AttributedStringStyle *)primaryPartStyle
                      secondaryPartStyle:(AttributedStringStyle *)secondaryPartStyle
                          formatterStyle:(BalanceFormatterStyle)formatterStyle
                   numberFilterFormatter:(id<NumbersFormatter>)numberFilterFormatter
{
    self = [super init];
    if (self) {
        self.primaryPartStyle = primaryPartStyle;
        self.secondaryPartStyle = secondaryPartStyle;
        self.formatterStyle = formatterStyle;
        self.numberFilterFormatter = numberFilterFormatter;
        
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

- (FormatterData *)formatNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign {
    let string = [self.numberFormatter stringFromNumber:number];
    
    return [self formatString:string sign:sign];
}

- (FormatterData *)formatString:(NSString *)inputString sign:(BalanceFormatterSign)sign {
    
    NSAttributedString *formattedString;
    NSString *string;
    let parseData = [self parseText:inputString];
    switch (parseData.parsingResult) {
        case ParsingResultZero:
        case ParsingResultInteger:
        {
            let integerParseData = [self parseText:inputString];
            formattedString = [self attributedFormatText:inputString
                                               parseData:integerParseData
                                                    sign:sign];
            string = [self applySign:sign text:inputString];
        }
            break;
        case ParsingResultFloat:
        {
            formattedString = [self attributedFormatText:inputString
                                               parseData:parseData
                                                    sign:sign];
            string = [self applySign:sign text:inputString];
        }
            break;
    }
    
    let filteredString = [self.numberFilterFormatter format:string].string;
    let number = [self.numberFormatter numberFromString:filteredString];
    
    return [[FormatterData alloc] initWithFormattedString:formattedString
                                                         string:string
                                                         number:number];
}

// MARK: - Private

- (NSAttributedString *)attributedFormatText:(NSString *)text
                                   parseData:(BalanceParseData *)parseData
                                        sign:(BalanceFormatterSign)sign
{
    
    var string = [[NSMutableAttributedString alloc] init];
    
    let formattedString = [self formattedStringWithText:text
                                              parseData:parseData];
    
    if (formattedString.primaryString != nil) {
        let signedPrimaryString = [self applySign:sign text:formattedString.primaryString];
        let primaryAttributedString = [[NSAttributedString alloc] initWithString:signedPrimaryString
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

- (BalanceParseData *)parseText:(NSString *)text {
    ParsingResult result;
    let components = [text componentsSeparatedByString:[self separator]];
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

- (NSString *)separator {
    let locale = [NSLocale currentLocale];
    return [locale objectForKey:NSLocaleDecimalSeparator];
}

- (FormattedStringData *)formattedStringWithText:(NSString *)text
                                       parseData:(BalanceParseData *)parseData
{
    var formattedString = [[FormattedStringData alloc] init];
    
    switch (parseData.parsingResult) {
        case ParsingResultZero:
        {
            formattedString.primaryString = nil;
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultInteger:
        {
            formattedString.primaryString = text;
            formattedString.secondaryString = nil;
        }
            break;
        case ParsingResultFloat:
        {
            let components = parseData.components;
            
            NSString *primaryString;
            NSString *secondaryString;
            
            switch (self.formatterStyle) {
                case BalanceFormatterStyleHundredths:
                {
                    primaryString = [NSString stringWithFormat:@"%@%@", components.firstObject, [self separator]];
                    secondaryString = components[1];
                    
                    if (secondaryString.length > 2) {
                        secondaryString = [secondaryString substringToIndex:2];
                    }
                }
                    break;
                case BalanceFormatterStyleTenThousandths:
                {
                    let location = [text rangeOfString:[self separator]].location + 3;
                    primaryString = [text substringToIndex:location];
                    secondaryString = [text substringFromIndex:location + 1];
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
