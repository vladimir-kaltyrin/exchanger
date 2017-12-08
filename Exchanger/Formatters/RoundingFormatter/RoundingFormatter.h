#import <Foundation/Foundation.h>

@protocol RoundingFormatter
- (nonnull NSString *)format:(nonnull NSNumber *)number;
@end
