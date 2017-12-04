#import <Foundation/Foundation.h>

@protocol BalanceFormatter
- (NSString *)formatBalance:(NSNumber *)balance;
- (NSAttributedString *)attributedFormatBalance:(NSString *)balance;
@end
