#import "CurrencyFormatter.h"

@implementation CurrencyFormatter

+ (NSString *)toString:(CurrencyType)currencyType {
    switch (currencyType) {
        case USD:
            return @"USD";
        case JPY:
            return @"JPY";
        case BGN:
            return @"BGN";
        case CZK:
            return @"CZK";
        case DKK:
            return @"DKK";
        case GBP:
            return @"GBP";
        case HUF:
            return @"HUF";
        case PLN:
            return @"PLN";
        case RON:
            return @"RON";
        case SEK:
            return @"SEK";
        case CHF:
            return @"CHF";
        case NOK:
            return @"NOK";
        case HRK:
            return @"HRK";
        case RUB:
            return @"RUB";
        case TRY:
            return @"TRY";
        case AUD:
            return @"AUD";
        case BRL:
            return @"BRL";
        case CAD:
            return @"CAD";
        case CNY:
            return @"CNY";
        case HKD:
            return @"HKD";
        case IDR:
            return @"IDR";
        case ILS:
            return @"ILS";
        case INR:
            return @"INR";
        case KRW:
            return @"KRW";
        case MXN:
            return @"MXN";
        case MYR:
            return @"MYR";
        case NZD:
            return @"NZD";
        case PHP:
            return @"PHP";
        case SGD:
            return @"SGD";
        case THB:
            return @"THB";
        case ZAR:
            return @"ZAR";
    }
}

@end
