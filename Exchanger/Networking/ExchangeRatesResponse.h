#import <Foundation/Foundation.h>

@class Currency;

@interface ExchangeRatesResponse : NSObject
@property (nonatomic, strong, readonly) NSArray<Currency *> *currencies;

- (instancetype)init __attribute__((unavailable("init not available")));

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
