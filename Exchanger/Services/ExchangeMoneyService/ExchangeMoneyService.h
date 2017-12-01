#import <Foundation/Foundation.h>
#import "Wallet.h"
#import "Currency.h"
#import "User.h"
#import "ExchangeMoneyResult.h"

@protocol ExchangeMoneyService <NSObject>

- (void)exchangeWithUser:(User *)user
             moneyAmount:(NSNumber *)moneyAmount
          sourceCurrency:(Currency *)sourceCurrency
          targetCurrency:(Currency *)targetCurrency
                onResult:(void(^)(ExchangeMoneyResult *))onResult;

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                             targetCurrency:(Currency *)targetCurrency
                                  onConvert:(void(^)(Currency *))onConvert;

@end
