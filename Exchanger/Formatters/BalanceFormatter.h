#import <Foundation/Foundation.h>
#import "AttributedStringStyle.h"

typedef NS_ENUM(NSInteger, BalanceFormatterStyle) {
    BalanceFormatterStyleHundredths,
    BalanceFormatterStyleTenThousandths
};

@interface BalanceFormatter : NSObject
@property (nonatomic, assign) BalanceFormatterStyle style;
@property (nonatomic, strong) AttributedStringStyle *primaryPartStyle;
@property (nonatomic, strong) AttributedStringStyle *secondaryPartStyle;

- (NSString *)formatBalance:(NSNumber *)balance;

- (NSAttributedString *)attributedFormatBalance:(NSString *)balance;

@end
