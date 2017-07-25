#import "ExchangeRatesData.h"
#import "Currency.h"

@interface ExchangeRatesData()
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@end

@implementation ExchangeRatesData

- (instancetype)initWithCurrencies:(NSArray<Currency *> *)currencies {
    if (self = [super init]) {
        self.currencies = currencies;
    }
    return self;
}

@end
