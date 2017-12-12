#import <Foundation/Foundation.h>

#import "FormatterResultData.h"

@protocol BalanceFormatter

- (FormatterResultData *)format:(NSString *)balance;

@end
