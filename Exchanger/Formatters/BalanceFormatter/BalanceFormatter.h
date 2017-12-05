#import <Foundation/Foundation.h>

@protocol BalanceFormatter
- (NSAttributedString *)attributedFormatBalance:(NSString *)balance;
@end
