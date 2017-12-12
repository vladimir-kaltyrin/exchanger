#import <Foundation/Foundation.h>
#import "ExchangeMoneyViewData.h"
#import "ObservableTextField.h"
#import "User.h"

@interface ExchangeMoneyViewDataBuilder : NSObject

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(NSString *)incomeInput
                expenseInput:(NSString *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                targetWallet:(Wallet *)targetWallet
                invertedRate:(NSNumber *)invertedRate
                onTextChange:(OnTextChange)onTextChange;

- (ExchangeMoneyViewData *)build;

@end
