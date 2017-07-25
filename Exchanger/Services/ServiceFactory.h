#import <Foundation/Foundation.h>
#import "ExchangeRatesService.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "XMLParser.h"

@protocol IServiceFactory <NSObject>
- (id<ExchangeRatesService>)exchangeRatesService;
- (id<ExchangeRatesUpdater>)exchangeRatesUpdater;
- (id<IExchangeMoneyService>)exchangeMoneyService;
- (id<XMLParser>)xmlParser;
@end

@interface ServiceFactory : NSObject<IServiceFactory>
@end
