#import <Foundation/Foundation.h>
#import "MoneyData.h"

@interface User : NSObject

- (instancetype)initWithWallet:(NSArray<MoneyData *> *)wallet;

- (MoneyData *)moneyDataWithCurrencyType:(CurrencyType)currencyType;

@end
