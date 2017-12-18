#import <Foundation/Foundation.h>

#import "ExchangeRatesService.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "KeyboardObserver.h"
#import "XMLParser.h"
#import "UserService.h"
#import "UserDataStorage.h"
#import "NetworkClient.h"

@protocol ServiceFactory <NSObject>
- (id<KeyboardObserver>)keyboardObserver;
- (id<ExchangeRatesService>)exchangeRatesService;
- (id<ExchangeRatesUpdater>)exchangeRatesUpdater;
- (id<ExchangeMoneyService>)exchangeMoneyService;
- (id<UserService>)userService;
- (id<XMLParser>)xmlParser;
- (id<UserDataStorage>)userDataStorage;
- (id<NetworkClient>)networkClient;
@end
