#import "ServiceFactoryImpl.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeRatesServiceImpl.h"
#import "ExchangeRatesUpdaterImpl.h"
#import "ExchangeMoneyServiceImpl.h"
#import "XMLParserImpl.h"
#import "UserServiceImpl.h"
#import "UserDataStorageImpl.h"
#import "NetworkClientImpl.h"

@implementation ServiceFactoryImpl

// MARK: - Init

+ (instancetype)instance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

// MARK: - ServiceFactory

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
    return [[UserServiceImpl alloc] initWithUserDataStorage:[self userDataStorage]];
}

- (id<XMLParser>)xmlParser {
    return [[XMLParserImpl alloc] init];
}
            
- (id<UserDataStorage>)userDataStorage {
    return [[UserDataStorageImpl alloc] init];
}

- (id<NetworkClient>)networkClient {
    return [[NetworkClientImpl alloc] initWithParser:[self xmlParser]];
}

@end
