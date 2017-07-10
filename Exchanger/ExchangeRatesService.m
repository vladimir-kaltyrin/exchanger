#import "XMLDictionary.h"
#import "ExchangeRatesService.h"

static NSString *const kXmlUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@implementation ExchangeRatesService {
}

- (void)fetchRates:(OnExchangeRatesServiceSuccess)onData
           onError:(OnExchangeRatesServiceFailure)onError
{
    NSURL *url = [[NSURL alloc] initWithString:kXmlUrl];
    XMLDictionaryParser *parser = [[XMLDictionaryParser alloc] init];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dictionary = [parser dictionaryWithData:data];
    }];
}

@end
