#import "CurrencyFormatterImpl.h"

@implementation CurrencyFormatterImpl

- (NSString *)toCodeString:(CurrencyType)currencyType {
    switch (currencyType) {
        case CurrencyTypeEUR:
            return @"EUR";
        case CurrencyTypeUSD:
            return @"USD";
        case CurrencyTypeGBP:
            return @"GBP";
        case CurrencyTypeNotFound:
            return nil;
    }
}

- (NSString *)toSignString:(CurrencyType)currencyType {
    switch (currencyType) {
        case CurrencyTypeEUR:
            return @"€";
        case CurrencyTypeUSD:
            return @"$";
        case CurrencyTypeGBP:
            return @"£";
        default:
            return [self toCodeString:currencyType];
    }
}

- (CurrencyType)currencyTypeFromString:(NSString *)string {
    if ([string isEqualToString:@"EUR"]) {
        return CurrencyTypeEUR;
    } else if ([string isEqualToString:@"USD"]) {
        return CurrencyTypeUSD;
    } else if ([string isEqualToString:@"GBP"]) {
        return CurrencyTypeGBP;
    } else {
        return CurrencyTypeNotFound;
    }
}

@end
