#import <Foundation/Foundation.h>
#import "ExchangeMoneyBalanceViewData.h"

@interface ExchangeMoneyCurrencyViewData : NSObject
@property (nonatomic, strong) ExchangeMoneyBalanceViewData *balance;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *difference;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) void(^onTextChange)();
@end
