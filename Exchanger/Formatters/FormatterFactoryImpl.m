#import "FormatterFactoryImpl.h"
#import "BalanceFormatterImpl.h"

@implementation FormatterFactoryImpl

+ (instancetype)instance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

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

@end
