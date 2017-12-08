#import <Foundation/Foundation.h>
#import "ExchangeMoneyViewData.h"
#import "User.h"

@interface ExchangeMoneyViewDataBuilder : NSObject

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                currentInput:(NSNumber *)currentInput
              formattedInput:(NSAttributedString *)formattedInput
          sourceCurrencyType:(CurrencyType)sourceCurrencyType
          targetCurrencyType:(CurrencyType)targetCurrencyType;

- (ExchangeMoneyViewData *)build;

@end
