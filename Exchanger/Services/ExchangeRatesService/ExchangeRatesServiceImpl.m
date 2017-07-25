#import "ExchangeRatesServiceImpl.h"
#import "ExchangeRatesResponse.h"
#import "XMLParser.h"

static NSString *const kXmlUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@interface ExchangeRatesServiceImpl()
@property (nonatomic, strong) id<XMLParser> parser;
@end

@implementation ExchangeRatesServiceImpl

- (instancetype)initWithParser:(id<XMLParser>)parser {
    if (self = [super init]) {
        self.parser = parser;
    }
    return self;
}

- (void)fetchRates:(OnExchangeRatesServiceSuccess)onData
           onError:(OnExchangeRatesServiceFailure)onError
{
    NSURL *url = [[NSURL alloc] initWithString:kXmlUrl];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.parser parse:data onComplete:^(NSDictionary *dictionary) {
            ExchangeRatesResponse *response = [[ExchangeRatesResponse alloc] initWithDictionary:dictionary];
            ExchangeRatesData *data = [[ExchangeRatesData alloc] initWithCurrencies:response.currencies];
            onData(data);
        }];
    }];
    [task resume];
}

@end
