#import <Foundation/Foundation.h>

@class Currency;

@interface ExchangeRatesResponse : NSObject
@property (nonatomic, strong, readonly) NSArray<Currency *> *currencies;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
