#import "CurrencyFormatter.h"

@implementation CurrencyFormatter

+ (NSString *)toString:(CurrencyType)currencyType {
    switch (currencyType) {
        case CurrencyTypeUSD:
            return @"USD";
        case CurrencyTypeJPY:
            return @"JPY";
        case CurrencyTypeBGN:
            return @"BGN";
        case CurrencyTypeCZK:
            return @"CZK";
        case CurrencyTypeDKK:
            return @"DKK";
        case CurrencyTypeGBP:
            return @"GBP";
        case CurrencyTypeHUF:
            return @"HUF";
        case CurrencyTypePLN:
            return @"PLN";
        case CurrencyTypeRON:
            return @"RON";
        case CurrencyTypeSEK:
            return @"SEK";
        case CurrencyTypeCHF:
            return @"CHF";
        case CurrencyTypeNOK:
            return @"NOK";
        case CurrencyTypeHRK:
            return @"HRK";
        case CurrencyTypeRUB:
            return @"RUB";
        case CurrencyTypeTRY:
            return @"TRY";
        case CurrencyTypeAUD:
            return @"AUD";
        case CurrencyTypeBRL:
            return @"BRL";
        case CurrencyTypeCAD:
            return @"CAD";
        case CurrencyTypeCNY:
            return @"CNY";
        case CurrencyTypeHKD:
            return @"HKD";
        case CurrencyTypeIDR:
            return @"IDR";
        case CurrencyTypeILS:
            return @"ILS";
        case CurrencyTypeINR:
            return @"INR";
        case CurrencyTypeKRW:
            return @"KRW";
        case CurrencyTypeMXN:
            return @"MXN";
        case CurrencyTypeMYR:
            return @"MYR";
        case CurrencyTypeNZD:
            return @"NZD";
        case CurrencyTypePHP:
            return @"PHP";
        case CurrencyTypeSGD:
            return @"SGD";
        case CurrencyTypeTHB:
            return @"THB";
        case CurrencyTypeZAR:
            return @"ZAR";
        case CurrencyTypeNotFound:
            return @"CurrencyTypeNotFound";
    }
}

+ (CurrencyType)fromString:(NSString *)string {
    if ([string isEqualToString:@"USD"]) {
        return CurrencyTypeUSD;
    } else if ([string isEqualToString:@"JPY"]) {
        return CurrencyTypeJPY;
    } else if ([string isEqualToString:@"BGN"]) {
        return CurrencyTypeBGN;
    } else if ([string isEqualToString:@"CZK"]) {
        return CurrencyTypeCZK;
    } else if ([string isEqualToString:@"DKK"]) {
        return CurrencyTypeDKK;
    } else if ([string isEqualToString:@"GBP"]) {
        return CurrencyTypeGBP;
    } else if ([string isEqualToString:@"HUF"]) {
        return CurrencyTypeHUF;
    } else if ([string isEqualToString:@"PLN"]) {
        return CurrencyTypePLN;
    } else if ([string isEqualToString:@"RON"]) {
        return CurrencyTypeRON;
    } else if ([string isEqualToString:@"SEK"]) {
        return CurrencyTypeSEK;
    } else if ([string isEqualToString:@"CHF"]) {
        return CurrencyTypeCHF;
    } else if ([string isEqualToString:@"NOK"]) {
        return CurrencyTypeNOK;
    } else if ([string isEqualToString:@"HRK"]) {
        return CurrencyTypeHRK;
    } else if ([string isEqualToString:@"RUB"]) {
        return CurrencyTypeRUB;
    } else if ([string isEqualToString:@"TRY"]) {
        return CurrencyTypeTRY;
    } else if ([string isEqualToString:@"AUD"]) {
        return CurrencyTypeAUD;
    } else if ([string isEqualToString:@"BRL"]) {
        return CurrencyTypeBRL;
    } else if ([string isEqualToString:@"CAD"]) {
        return CurrencyTypeCAD;
    } else if ([string isEqualToString:@"CNY"]) {
        return CurrencyTypeCNY;
    } else if ([string isEqualToString:@"BRL"]) {
        return CurrencyTypeBRL;
    } else if ([string isEqualToString:@"HKD"]) {
        return CurrencyTypeHKD;
    } else if ([string isEqualToString:@"IDR"]) {
        return CurrencyTypeIDR;
    } else if ([string isEqualToString:@"ILS"]) {
        return CurrencyTypeILS;
    } else if ([string isEqualToString:@"INR"]) {
        return CurrencyTypeINR;
    } else if ([string isEqualToString:@"KRW"]) {
        return CurrencyTypeKRW;
    } else if ([string isEqualToString:@"MXN"]) {
        return CurrencyTypeMXN;
    } else if ([string isEqualToString:@"MYR"]) {
        return CurrencyTypeMYR;
    } else if ([string isEqualToString:@"NZD"]) {
        return CurrencyTypeNZD;
    } else if ([string isEqualToString:@"PHP"]) {
        return CurrencyTypePHP;
    } else if ([string isEqualToString:@"SGD"]) {
        return CurrencyTypeSGD;
    } else if ([string isEqualToString:@"THB"]) {
        return CurrencyTypeTHB;
    } else if ([string isEqualToString:@"ZAR"]) {
        return CurrencyTypeZAR;
    } else {
        return CurrencyTypeNotFound;
    }
}

@end
