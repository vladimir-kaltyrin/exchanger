#import "ExchangeRatesServiceImpl.h"
#import "ExchangeRatesResponse.h"
#import "Currency.h"
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
        
        __weak typeof(self) weakSelf = self;
        [self.parser parse:data onComplete:^(NSDictionary *dictionary) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                ExchangeRatesResponse *response = [[ExchangeRatesResponse alloc] initWithDictionary:dictionary];
                ExchangeRatesData *data = [weakSelf processResponse:response];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    onData(data);
                });
            });
        }];
    }];
    [task resume];
}

- (ExchangeRatesData *)processResponse:(ExchangeRatesResponse *)response {
    NSArray *currencies = [response.currencies filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Currency * _Nullable currency, NSDictionary<NSString *,id> * _Nullable bindings) {
        switch (currency.currencyType) {
            case CurrencyTypeUSD:
                return YES;
            case CurrencyTypeGBP:
                return YES;
            default:
                return NO;
        }
    }]];
    
    Currency *eur = [Currency currencyWithType:CurrencyTypeEUR];
    eur.rate = @1.0;
    
    currencies = [currencies arrayByAddingObject:eur];
    
    return [[ExchangeRatesData alloc] initWithCurrencies:currencies];;
}

@end
