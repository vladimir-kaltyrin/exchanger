#import "User+CoreData.h"
#import "Wallet+CoreData.h"
#import "Currency+CoreData.h"
#import "ConvenientObjC.h"

@implementation User (CoreData)

+ (User *)userWithManagedUser:(ManagedUser *)managedUser
{
    let wallets = [@[managedUser.usdWallet, managedUser.gbpWallet, managedUser.eurWallet] map:^id(ManagedWallet *managedWallet) {
        return [Wallet walletWithManagedWallet:managedWallet];
    }];
    
    return [[User alloc] initWithWallets:wallets];
}

@end
