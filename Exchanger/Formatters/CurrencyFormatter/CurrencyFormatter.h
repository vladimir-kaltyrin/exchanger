#import "CurrencyType.h"

@protocol CurrencyFormatter
- (nonnull NSString *)toCodeString:(CurrencyType)currencyType;
- (nonnull NSString *)toSignString:(CurrencyType)currencyType;
- (CurrencyType)currencyTypeFromString:(nonnull NSString *)string;
@end
