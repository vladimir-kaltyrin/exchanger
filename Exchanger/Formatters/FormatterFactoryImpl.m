#import "FormatterFactoryImpl.h"
#import "BalanceFormatterImpl.h"
#import "CurrencyFormatterImpl.h"

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
    return [[BalanceFormatterImpl alloc] initWithPrimaryPartStyle:nil
                                               secondaryPartStyle:nil
                                                   formatterStyle:BalanceFormatterStyleHundredths];
}

- (id<BalanceFormatter>)currentBalanceFormatter {
    return [[BalanceFormatterImpl alloc] initWithPrimaryPartStyle:nil
                                               secondaryPartStyle:nil
                                                   formatterStyle:BalanceFormatterStyleTenThousandths];
}

- (id<CurrencyFormatter>)currencyFormatter {
    return [[CurrencyFormatterImpl alloc] init];
}

@end
