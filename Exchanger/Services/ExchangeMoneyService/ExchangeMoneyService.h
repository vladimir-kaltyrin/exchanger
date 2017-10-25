#import <Foundation/Foundation.h>
#import "MoneyData.h"
#import "Currency.h"
#import "User.h"

@protocol IExchangeMoneyService <NSObject>
- (void)exchangeMoney:(NSNumber *)money
       sourceCurrency:(Currency *)sourceCurrency
       targetCurrency:(Currency *)targetCurrency
             onResult:(void(^)(MoneyData *))onResult;

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                                   targetCurrency:(Currency *)targetCurrency
                                        onConvert:(void(^)(Currency *))onConvert;

@end

@interface ExchangeMoneyService : NSObject<IExchangeMoneyService>
@end
