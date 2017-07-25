#import <Foundation/Foundation.h>
#import "MoneyData.h"
#import "Currency.h"

@protocol IExchangeMoneyService <NSObject>
- (void)exchange:(MoneyData *)moneyData
      toCurrency:(Currency *)currency
        onResult:(void(^)(MoneyData *))onResult;
@end

@interface ExchangeMoneyService : NSObject<IExchangeMoneyService>
@end
