#import <Foundation/Foundation.h>
#import "ExchangeRatesService.h"
#import "XMLParser.h"

@interface ExchangeRatesServiceImpl : NSObject<ExchangeRatesService>

- (instancetype)initWithParser:(id<XMLParser>)parser;

@end
