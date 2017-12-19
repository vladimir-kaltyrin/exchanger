#import <Foundation/Foundation.h>
#import "AttributedStringStyle.h"
#import "BalanceFormatter.h"
#import "NumberFilterFormatter.h"

typedef NS_ENUM(NSInteger, BalanceFormatterStyle) {
    BalanceFormatterStyleHundredths,
    BalanceFormatterStyleTenThousandths
};

@interface BalanceFormatterImpl : NSObject<BalanceFormatter>

- (instancetype _Nonnull)init __attribute__((unavailable("init not available")));

- (instancetype _Nonnull)initWithPrimaryPartStyle:(nullable AttributedStringStyle *)primaryPartStyle
                               secondaryPartStyle:(nullable AttributedStringStyle *)secondaryPartStyle
                                   formatterStyle:(BalanceFormatterStyle)formatterStyle
                            numberFilterFormatter:(nonnull id<NumberFilterFormatter>)numberFilterFormatter
                                           locale:(nonnull NSLocale *)locale;

@end
