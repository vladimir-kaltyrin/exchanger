#import <Foundation/Foundation.h>
#import "ExchangeRatesService.h"
#import "XMLParser.h"

@interface ExchangeRatesServiceImpl : NSObject<ExchangeRatesService>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithParser:(id<XMLParser>)parser;

@end
