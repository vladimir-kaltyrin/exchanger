#import <Foundation/Foundation.h>
#import "Wallet.h"
#import "Currency.h"
#import "User.h"

@protocol IExchangeMoneyService <NSObject>
- (void)exchangeMoney:(NSNumber *)money
       sourceCurrency:(Currency *)sourceCurrency
       targetCurrency:(Currency *)targetCurrency
             onResult:(void(^)(Wallet *))onResult;

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                             targetCurrency:(Currency *)targetCurrency
                                  onConvert:(void(^)(Currency *))onConvert;

@end

@interface ExchangeMoneyService : NSObject<IExchangeMoneyService>
@end
