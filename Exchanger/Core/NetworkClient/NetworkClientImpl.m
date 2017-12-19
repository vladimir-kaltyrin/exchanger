#import "NetworkClientImpl.h"
#import "ServiceFactory.h"
#import "ConvenientObjC.h"
#import "ExchangeRatesResponse.h"

static let kApiUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";
static let kRequestTimeout = 30.f;

@interface NetworkClientImpl()
@property (nonatomic, strong) id<XMLParser> parser;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation NetworkClientImpl

// MARK: - Init

- (instancetype)initWithParser:(id<XMLParser>)parser {
    if (self = [super init]) {
        self.parser = parser;
        
        let configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = kRequestTimeout;
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

// MARK: - Public

- (void)fetchRates:(OnFetchRates)onData
           onError:(OnError)onError
{
    
    let url = [[NSURL alloc] initWithString:kApiUrl];
    
    __weak typeof(self) welf = self;
    let task = [self.session dataTaskWithURL:url
                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                               
                               [self.parser parse:data onComplete:^(NSDictionary *dictionary) {
                                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                       let response = [[ExchangeRatesResponse alloc] initWithDictionary:dictionary];
                                       let data = [welf processResponse:response];
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           onData(data);
                                           
                                       });
                                   });
                               }];
                           }];
    [task resume];
}

- (ExchangeRatesData *)processResponse:(ExchangeRatesResponse *)response {
    
    var currencies = [response.currencies select:^BOOL(Currency *currency) {
        switch (currency.currencyType) {
            case CurrencyTypeUSD:
            case CurrencyTypeGBP:
                return YES;
            default:
                return NO;
        }
    }];
    
    Currency *eur = [Currency currencyWithType:CurrencyTypeEUR];
    
    currencies = [currencies arrayByAddingObject:eur];
    
    return [[ExchangeRatesData alloc] initWithCurrencies:currencies];;
}

@end
