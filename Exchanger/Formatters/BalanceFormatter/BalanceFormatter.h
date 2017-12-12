#import <Foundation/Foundation.h>

#import "FormatterResultData.h"

typedef NS_ENUM(NSInteger, BalanceFormatterSign) {
    BalanceFormatterSignMinus,
    BalanceFormatterSignPlus,
    BalanceFormatterSignNone
};

@protocol BalanceFormatter

- (FormatterResultData *)format:(NSString *)balance sign:(BalanceFormatterSign)sign;

@end
