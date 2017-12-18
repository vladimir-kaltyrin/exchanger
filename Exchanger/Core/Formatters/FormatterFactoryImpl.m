#import "ConvenientObjC.h"
#import "FormatterFactoryImpl.h"
#import "BalanceFormatterImpl.h"
#import "CurrencyFormatterImpl.h"
#import "NumbersFormatterImpl.h"
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
                                                   formatterStyle:BalanceFormatterStyleHundredths];
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
                                                   formatterStyle:BalanceFormatterStyleTenThousandths];
}

- (id<CurrencyFormatter>)currencyFormatter {
    return [[CurrencyFormatterImpl alloc] init];
}

- (id<NumbersFormatter>)numbersFormatter {
    return [[NumbersFormatterImpl alloc] init];
}

- (id<RoundingFormatter>)roundingFormatter {
    return [[RoundingFormatterImpl alloc] init];
}

@end
