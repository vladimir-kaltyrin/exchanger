#import "RoundingFormatterImpl.h"

@interface RoundingFormatterImpl()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation RoundingFormatterImpl

- (NSString *)format:(NSNumber *)number {
    
    if (self.numberFormatter == nil) {
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.minimumIntegerDigits = 1;
        self.numberFormatter.maximumFractionDigits = 2;
    }
    
    return [self.numberFormatter stringFromNumber:number];
}

@end
