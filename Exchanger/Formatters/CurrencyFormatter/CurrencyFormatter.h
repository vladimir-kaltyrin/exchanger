#import "CurrencyType.h"

@protocol CurrencyFormatter
- (NSString *)toCodeString:(CurrencyType)currencyType;
- (NSString *)toSignString:(CurrencyType)currencyType;
- (CurrencyType)currencyTypeFromString:(NSString *)string;
@end
