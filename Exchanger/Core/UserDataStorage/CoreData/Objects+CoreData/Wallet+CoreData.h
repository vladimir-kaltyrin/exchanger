#import "Wallet.h"
#import "CoreDataHeaders.h"

@interface Wallet (CoreData)

+ (Wallet *)walletWithManagedWallet:(ManagedWallet *)managedWallet;

@end
