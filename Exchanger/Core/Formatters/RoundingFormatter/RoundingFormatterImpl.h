#import <Foundation/Foundation.h>
#import "RoundingFormatter.h"

@interface RoundingFormatterImpl : NSObject<RoundingFormatter>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithNumberFormatter:(NSNumberFormatter *)numberFormatter;

@end
