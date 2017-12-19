#import "ConvenientObjC.h"
#import "FormatterFactoryImpl.h"
#import "BalanceFormatterImpl.h"
#import "CurrencyFormatterImpl.h"
#import "NumberFilterFormatterImpl.h"
#import "RoundingFormatterImpl.h"

@implementation FormatterFactoryImpl

// MARK: - Init

+ (instancetype)instance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

// MARK: - FormatterFactory

- (id<BalanceFormatter>)exchangeCurrencyInputFormatter {
    
    var primaryStringStyle = [[AttributedStringStyle alloc] init];
    primaryStringStyle.font = [UIFont systemFontOfSize:34];
    primaryStringStyle.foregroundColor = [UIColor whiteColor];
    
    var secondaryStringStyle = [[AttributedStringStyle alloc] init];
    secondaryStringStyle.font = [UIFont systemFontOfSize:28];
    secondaryStringStyle.foregroundColor = [UIColor whiteColor];
    
    return [[BalanceFormatterImpl alloc] initWithPrimaryPartStyle:primaryStringStyle
                                               secondaryPartStyle:secondaryStringStyle
                                                   formatterStyle:BalanceFormatterStyleHundredths
                                            numberFilterFormatter:[self numberFilterFormatter]
                                                           locale:[NSLocale currentLocale]];
}

- (id<BalanceFormatter>)currentBalanceFormatter {
    
    var primaryStringStyle = [[AttributedStringStyle alloc] init];
    primaryStringStyle.font = [UIFont systemFontOfSize:18];
    primaryStringStyle.foregroundColor = [UIColor blackColor];
    
    var secondaryStringStyle = [[AttributedStringStyle alloc] init];
    secondaryStringStyle.font = [UIFont systemFontOfSize:15];
    secondaryStringStyle.foregroundColor = [UIColor blackColor];
    
    return [[BalanceFormatterImpl alloc] initWithPrimaryPartStyle:primaryStringStyle
                                               secondaryPartStyle:secondaryStringStyle
                                                   formatterStyle:BalanceFormatterStyleTenThousandths
                                            numberFilterFormatter:[self numberFilterFormatter]
                                                           locale:[NSLocale currentLocale]];
}

- (id<CurrencyFormatter>)currencyFormatter {
    return [[CurrencyFormatterImpl alloc] init];
}

- (id<NumberFilterFormatter>)numberFilterFormatter {
    let numberFormatter = [[NSNumberFormatter alloc] init];
    
    return [[NumberFilterFormatterImpl alloc] initWithNumberFormatter:numberFormatter];
}

- (id<RoundingFormatter>)roundingFormatter {
    let numberFormatter = [[NSNumberFormatter alloc] init];
    
    return [[RoundingFormatterImpl alloc] initWithNumberFormatter:numberFormatter];
}

@end
