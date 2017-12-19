#import <Foundation/Foundation.h>
#import "NumberFilterFormatterData.h"

@protocol NumberFilterFormatter
- (nonnull NumberFilterFormatterData *)format:(nonnull NSString *)string;
@end
