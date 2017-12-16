#import <Foundation/Foundation.h>
#import "FormatterResultData.h"

@protocol BalanceFormatter

- (FormatterResultData *)formatString:(NSString *)string sign:(BalanceFormatterSign)sign;

- (FormatterResultData *)formatNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign;

@end
