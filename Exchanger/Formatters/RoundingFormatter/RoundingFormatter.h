#import <Foundation/Foundation.h>

@protocol RoundingFormatter
- (nonnull NSString *)format:(nonnull NSNumber *)number;

- (void)setLocale:(NSLocale *)locale;
@end
