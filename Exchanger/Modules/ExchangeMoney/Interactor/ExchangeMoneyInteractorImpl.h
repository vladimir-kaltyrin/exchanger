#import <Foundation/Foundation.h>
#import "ExchangeMoneyInteractor.h"
#import "ExchangeMoneyService.h"
#import "ExchangeRatesUpdater.h"

@class User;

@interface ExchangeMoneyInteractorImpl : NSObject<ExchangeMoneyInteractor>

- (instancetype)initWithUser:(User *)user
        exchangeMoneyService:(id<IExchangeMoneyService>)exchangeMoneyService
        exchangeRatesUpdater:(id<ExchangeRatesUpdater>)exchangeRatesUpdater;

@end
