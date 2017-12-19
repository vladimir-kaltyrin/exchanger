#import <Foundation/Foundation.h>
#import "AttributedStringStyle.h"
#import "BalanceFormatter.h"
#import "NumbersFormatter.h"

typedef NS_ENUM(NSInteger, BalanceFormatterStyle) {
    BalanceFormatterStyleHundredths,
    BalanceFormatterStyleTenThousandths
};

@interface BalanceFormatterImpl : NSObject<BalanceFormatter>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithPrimaryPartStyle:(AttributedStringStyle *)primaryPartStyle
                      secondaryPartStyle:(AttributedStringStyle *)secondaryPartStyle
                          formatterStyle:(BalanceFormatterStyle)formatterStyle
                   numberFilterFormatter:(id<NumbersFormatter>)numberFilterFormatter;

@end
