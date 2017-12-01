#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface User : NSObject

- (instancetype)initWithWallets:(NSArray<Wallet *> *)wallets;

- (void)setWallet:(Wallet *)wallet withCurrencyType:(CurrencyType)currencyType;

- (Wallet *)walletWithCurrencyType:(CurrencyType)currencyType;

@end
