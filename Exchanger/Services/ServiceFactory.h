#import <Foundation/Foundation.h>
#import "ExchangeRatesService.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "KeyboardObserver.h"
#import "XMLParser.h"
#import "UserService.h"

@protocol IServiceFactory <NSObject>
- (id<KeyboardObserver>)keyboardObserver;
- (id<ExchangeRatesService>)exchangeRatesService;
- (id<ExchangeRatesUpdater>)exchangeRatesUpdater;
- (id<IExchangeMoneyService>)exchangeMoneyService;
- (id<UserService>)userService;
- (id<XMLParser>)xmlParser;
@end

@interface ServiceFactory : NSObject<IServiceFactory>
@end
