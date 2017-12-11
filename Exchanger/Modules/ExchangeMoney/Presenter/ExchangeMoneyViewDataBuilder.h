#import <Foundation/Foundation.h>
#import "ExchangeMoneyViewData.h"
#import "User.h"

@interface ExchangeMoneyViewDataBuilder : NSObject

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(NSNumber *)incomeInput
                expenseInput:(NSNumber *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                targetWallet:(Wallet *)targetWallet
                invertedRate:(NSNumber *)invertedRate;

- (ExchangeMoneyViewData *)build;

@end
