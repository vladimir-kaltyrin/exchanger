#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface User : NSObject

- (instancetype)initWithWallets:(NSArray<Wallet *> *)wallets;

- (Wallet *)walletWithCurrencyType:(CurrencyType)currencyType;

@end
