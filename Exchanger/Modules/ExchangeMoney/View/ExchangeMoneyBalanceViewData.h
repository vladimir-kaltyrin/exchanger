#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ExchangeMoneyBalanceType) {
    Normal,
    Insufficient
};

@interface ExchangeMoneyBalanceViewData : NSObject
@property (nonatomic, assign) ExchangeMoneyBalanceType balanceType;
@property (nonatomic, strong) NSString *balanceValue;
@end
