#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface ExchangeMoneyData : NSObject
@property (nonatomic, strong, readonly) Wallet *sourceWallet;
@property (nonatomic, strong, readonly) Wallet *targetWallet;

- (instancetype)initWithSourceWallet:(Wallet *)sourceWallet
                        targetWallet:(Wallet *)targetWallet;

@end
