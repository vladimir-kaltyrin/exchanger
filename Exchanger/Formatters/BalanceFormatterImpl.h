#import <Foundation/Foundation.h>
#import "AttributedStringStyle.h"

typedef NS_ENUM(NSInteger, BalanceFormatterStyle) {
    BalanceFormatterStyleHundredths,
    BalanceFormatterStyleTenThousandths
};

@interface BalanceFormatter : NSObject
@property (nonatomic, assign) BalanceFormatterStyle style;

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithPrimaryPartStyle:(AttributedStringStyle *)primaryPartStyle
                      secondaryPartStyle:(AttributedStringStyle *)secondaryPartStyle;

- (NSString *)formatBalance:(NSNumber *)balance;

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance;

@end
