#import <Foundation/Foundation.h>
#import "CurrencyType.h"

@interface CurrencyFormatter : NSObject

+ (NSString *)toCodeString:(CurrencyType)currencyType;

+ (NSString *)toSignString:(CurrencyType)currencyType;

+ (CurrencyType)currencyTypeFromString:(NSString *)string;

@end
