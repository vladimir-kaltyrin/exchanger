#import "CurrencyType.h"

@protocol CurrencyFormatter
- (nullable NSString *)toCodeString:(CurrencyType)currencyType;
- (nonnull NSString *)toSignString:(CurrencyType)currencyType;
- (CurrencyType)currencyTypeFromString:(nonnull NSString *)string;
@end
