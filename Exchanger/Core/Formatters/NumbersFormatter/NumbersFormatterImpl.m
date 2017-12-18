#import "ConvenientObjC.h"
#import "NumbersFormatterImpl.h"

@interface NumbersFormatterImpl()
@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) NSLocale *locale;
@end

@implementation NumbersFormatterImpl

// MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.formatter = [[NSNumberFormatter alloc] init];
        self.locale = [NSLocale currentLocale];
    }
    return self;
}

// MARK: - NumbersFormatter

- (nonnull NumbersFormatterData *)format:(nonnull NSString *)string; {
    var resultString = [self filterNonNumericAndSeparatorCharacters:string];
    resultString = [self filterExtraSeparators:resultString];
    resultString = [self filterStringEqualToSeparator:resultString];
    resultString = [self filterLeadingZeros:resultString];
    
    let resultNumber = [self.formatter numberFromString:resultString];
    
    var result = [[NumbersFormatterData alloc] init];
    result.string = resultString;
    result.number = resultNumber;
    
    return result;
}

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    
    self.formatter.locale = self.locale;
}

// MARK: - Private

- (NSString *)separator {
    return [self.locale objectForKey:NSLocaleDecimalSeparator];
}

- (NSString *)filterNonNumericAndSeparatorCharacters:(NSString *)targetString {
    var set = [NSMutableCharacterSet decimalDigitCharacterSet];
    
    let separator = [self separator];
    
    [set addCharactersInString:separator];
    [set invert];
    
    return [[targetString componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}

- (NSString *)filterExtraSeparators:(NSString *)targetString {
    let separator = [self separator];
    let components = [targetString componentsSeparatedByString:separator];
    if (components.count > 2) {
        let index = [targetString rangeOfString:separator].location;
        let range = NSMakeRange(index + 1, targetString.length - index - 1);
        return [targetString stringByReplacingOccurrencesOfString:separator
                                                                 withString:@""
                                                                    options:0
                                                                      range:range];
    }
    return targetString;
}

- (NSString *)filterStringEqualToSeparator:(NSString *)targetString {
    let separator = [self separator];
    if ([targetString isEqualToString:separator]) {
        return @"";
    }
    return targetString;
}

- (NSString *)filterLeadingZeros:(NSString *)targetString {
    
    if ([targetString isEqualToString:@"0"]) {
        return targetString;
    }
    
    let range = [targetString rangeOfString:@"^0*" options:NSRegularExpressionSearch];
    let result = [targetString stringByReplacingCharactersInRange:range withString:@""];
    
    return [result isEqualToString:@""] ? @"0" : result;
}

@end
