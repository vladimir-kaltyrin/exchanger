#import <Foundation/Foundation.h>
#import "NumberFilterFormatter.h"

@interface NumberFilterFormatterImpl : NSObject <NumberFilterFormatter>

- (instancetype _Nonnull)init __attribute__((unavailable("init not available")));

- (instancetype _Nonnull)initWithNumberFormatter:(nonnull NSNumberFormatter *)numberFormatter;

@end
