#import <Foundation/Foundation.h>
#import "FormatterData.h"

@protocol BalanceFormatter

- (FormatterData *)formatString:(NSString *)string sign:(BalanceFormatterSign)sign;

- (FormatterData *)formatNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign;

@end
