#import <Foundation/Foundation.h>
#import "NumbersFormatterData.h"

@protocol NumbersFormatter
- (nonnull NumbersFormatterData *)format:(nonnull NSString *)string;

- (void)setLocale:(NSLocale *_Nonnull)locale;
@end
