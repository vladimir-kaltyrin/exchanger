#import <Foundation/Foundation.h>
#import "User.h"

@class ExchangeMoneyData;

@protocol UserService <NSObject>

- (void)currentUser:(void(^)(User *))onCurrenUser;

- (void)updateUserWithExchangeMoneyData:(ExchangeMoneyData *)exchangeMoneyData;

@end
