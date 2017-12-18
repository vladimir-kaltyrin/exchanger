#import "RoundingFormatterImpl.h"

@interface RoundingFormatterImpl()
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

@implementation RoundingFormatterImpl

// MARK: - RoundingFormatter

- (NSString *)format:(NSNumber *)number {
    return [self.numberFormatter stringFromNumber:number];
}

- (void)setLocale:(NSLocale *)locale {
    self.numberFormatter.locale = locale;
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
