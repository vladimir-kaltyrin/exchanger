#import "RoundingFormatterImpl.h"

@interface RoundingFormatterImpl()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation RoundingFormatterImpl

// MARK: - Init

- (instancetype)initWithNumberFormatter:(NSNumberFormatter *)numberFormatter {
    self = [super init];
    if (self) {
        self.numberFormatter = numberFormatter;
    }
    return self;
}

// MARK: - RoundingFormatter

- (NSString *)format:(NSNumber *)number {
    return [self.numberFormatter stringFromNumber:number];
}

@end
