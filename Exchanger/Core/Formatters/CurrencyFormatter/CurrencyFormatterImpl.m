#import "CurrencyFormatterImpl.h"

@interface CurrencyFormatterImpl()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation CurrencyFormatterImpl

// MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return self;
}

// MARK: - Public

- (NSString *)toCodeString:(CurrencyType)currencyType {
    switch (currencyType) {
        case CurrencyTypeEUR:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
            return self.numberFormatter.currencyCode;
        }
            break;
        case CurrencyTypeUSD:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
            return self.numberFormatter.currencyCode;
        }
            break;
        case CurrencyTypeGBP:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_UK"];
            return self.numberFormatter.currencyCode;
        }
            break;
        case CurrencyTypeNotFound:
        {
            self.numberFormatter.locale = [NSLocale currentLocale];
            return nil;
        }
            
    }
}

- (NSString *)toSignString:(CurrencyType)currencyType {
    switch (currencyType) {
        case CurrencyTypeEUR:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
            return self.numberFormatter.currencySymbol;
        }
            break;
        case CurrencyTypeUSD:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
            return self.numberFormatter.currencySymbol;
        }
            break;
        case CurrencyTypeGBP:
        {
            self.numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_UK"];
            return self.numberFormatter.currencySymbol;
        }
            break;
        default:
        {
            self.numberFormatter.locale = [NSLocale currentLocale];
            return [self toCodeString:currencyType];
        }
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
