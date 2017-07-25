#import <Foundation/Foundation.h>

@class Currency;

@interface ExchangeRatesData : NSObject
@property (nonatomic, strong, readonly) NSArray<Currency *> *currencies;

- (instancetype)initWithCurrencies:(NSArray<Currency *> *)currencies;

@end
