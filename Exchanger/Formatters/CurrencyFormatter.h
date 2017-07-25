#import <Foundation/Foundation.h>
#import "CurrencyType.h"

@interface CurrencyFormatter : NSObject

+ (NSString *)toString: (CurrencyType)currencyType;

+ (CurrencyType)fromString: (NSString *)string;

@end
