#import "ServiceFactory.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeRatesServiceImpl.h"
#import "ExchangeRatesUpdaterImpl.h"
#import "XMLParserImpl.h"

@implementation ServiceFactory

- (id<KeyboardObserver>)keyboardObserver {
    return [[KeyboardObserverImpl alloc] init];
}

- (id<ExchangeRatesService>)exchangeRatesService {
    return [[ExchangeRatesServiceImpl alloc] initWithParser:[self xmlParser]];
}

- (id<ExchangeRatesUpdater>)exchangeRatesUpdater {
    return [[ExchangeRatesUpdaterImpl alloc] initWithExchangeRatesService:[self exchangeRatesService]];
}

- (id<IExchangeMoneyService>)exchangeMoneyService {
    return [[ExchangeMoneyService alloc] init];
}

- (id<XMLParser>)xmlParser {
    return [[XMLParserImpl alloc] init];
}

@end
