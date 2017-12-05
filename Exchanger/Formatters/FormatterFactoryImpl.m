#import "FormatterFactoryImpl.h"
#import "BalanceFormatterImpl.h"
#import "CurrencyFormatterImpl.h"
#import "NumbersFormatterImpl.h"

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
    
    AttributedStringStyle *primaryStringStyle = [[AttributedStringStyle alloc] init];
    primaryStringStyle.font = [UIFont systemFontOfSize:23];
    primaryStringStyle.foregroundColor = [UIColor whiteColor];
    
    AttributedStringStyle *secondaryStringStyle = [[AttributedStringStyle alloc] init];
    secondaryStringStyle.font = [UIFont systemFontOfSize:17];
    secondaryStringStyle.foregroundColor = [UIColor whiteColor];
    
    return [[BalanceFormatterImpl alloc] initWithPrimaryPartStyle:primaryStringStyle
                                               secondaryPartStyle:secondaryStringStyle
                                                   formatterStyle:BalanceFormatterStyleHundredths];
}

- (id<BalanceFormatter>)currentBalanceFormatter {
    
    AttributedStringStyle *primaryStringStyle = [[AttributedStringStyle alloc] init];
    primaryStringStyle.font = [UIFont systemFontOfSize:18];
    primaryStringStyle.foregroundColor = [UIColor whiteColor];
    
    AttributedStringStyle *secondaryStringStyle = [[AttributedStringStyle alloc] init];
    secondaryStringStyle.font = [UIFont systemFontOfSize:15];
    secondaryStringStyle.foregroundColor = [UIColor whiteColor];
    
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

@end
