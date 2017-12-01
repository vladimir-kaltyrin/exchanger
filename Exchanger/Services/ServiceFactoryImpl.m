#import "ServiceFactoryImpl.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeRatesServiceImpl.h"
#import "ExchangeRatesUpdaterImpl.h"
#import "ExchangeMoneyServiceImpl.h"
#import "XMLParserImpl.h"
#import "UserServiceImpl.h"

@implementation ServiceFactoryImpl

- (id<KeyboardObserver>)keyboardObserver {
    return [[KeyboardObserverImpl alloc] init];
}

- (id<ExchangeRatesService>)exchangeRatesService {
    return [[ExchangeRatesServiceImpl alloc] initWithParser:[self xmlParser]];
}

- (id<ExchangeRatesUpdater>)exchangeRatesUpdater {
    return [[ExchangeRatesUpdaterImpl alloc] initWithExchangeRatesService:[self exchangeRatesService]];
}

- (id<ExchangeMoneyService>)exchangeMoneyService {
    return [[ExchangeMoneyServiceImpl alloc] init];
}

- (id<UserService>)userService {
    return [[UserServiceImpl alloc] init];
}

- (id<XMLParser>)xmlParser {
    return [[XMLParserImpl alloc] init];
}

@end
