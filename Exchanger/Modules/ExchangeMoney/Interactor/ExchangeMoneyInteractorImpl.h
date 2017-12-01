#import <Foundation/Foundation.h>
#import "ExchangeMoneyInteractor.h"
#import "ExchangeMoneyService.h"
#import "ExchangeRatesUpdater.h"
#import "UserService.h"

@class User;

@interface ExchangeMoneyInteractorImpl : NSObject<ExchangeMoneyInteractor>

- (instancetype)initWithUserService:(id<UserService>)userService
               exchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService
               exchangeMoneyService:(id<ExchangeMoneyService>)exchangeMoneyService
               exchangeRatesUpdater:(id<ExchangeRatesUpdater>)exchangeRatesUpdater;


@end
