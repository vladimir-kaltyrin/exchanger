#import <Foundation/Foundation.h>
#import "ExchangeMoneyViewData.h"
#import "ObservableTextField.h"
#import "User.h"
#import "CurrencyExchangeType.h"

typedef void(^OnInputChange)(NSString *text, CurrencyExchangeType exchangeType, CurrencyType currencyType);
typedef FormatterResultData *(^TextFieldAttributedStringFormatter)(NSString *text);

@interface ExchangeMoneyViewDataBuilder : NSObject

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                 incomeInput:(FormatterResultData *)incomeInput
                expenseInput:(FormatterResultData *)expenseInput
              sourceCurrency:(Currency *)sourceCurrency
              targetCurrency:(Currency *)targetCurrency
                invertedRate:(NSNumber *)invertedRate
                isDeficiency:(BOOL)isDeficiency
               onInputChange:(OnInputChange)onInputChange;

- (ExchangeMoneyViewData *)build;

@end
