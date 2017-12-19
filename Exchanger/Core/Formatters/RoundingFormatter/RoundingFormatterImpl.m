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

// MARK: - Private

- (NSNumberFormatter *)numberFormatter {
    if (_numberFormatter == nil) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.minimumIntegerDigits = 1;
        _numberFormatter.maximumFractionDigits = 2;
    }
    return _numberFormatter;
}

@end
