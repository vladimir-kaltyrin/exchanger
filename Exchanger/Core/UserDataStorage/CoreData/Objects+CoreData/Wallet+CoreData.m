#import "Wallet+CoreData.h"
#import "Currency+CoreData.h"
#import "ConvenientObjC.h"

@implementation Wallet (CoreData)

+ (Wallet *)walletWithManagedWallet:(ManagedWallet *)managedWallet {
    
    let currency = [Currency currencyWithManagedCurrency:managedWallet.currency];
    let amount = [NSNumber numberWithDouble:managedWallet.amount];
    
    return [[Wallet alloc] initWithCurrency:currency
                                     amount:amount];
}

@end
