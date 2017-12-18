#import "ManagedWallet+Mapping.h"
#import "ManagedCurrency+Mapping.h"
#import "ConvenientObjC.h"

@implementation ManagedWallet (Mapping)

+ (ManagedWallet *)walletInsertIntoContext:(NSManagedObjectContext *)context {
    
    let entity = [NSEntityDescription entityForName:@"ManagedWallet" inManagedObjectContext:context];
    
    return [[ManagedWallet alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

- (void)setWallet:(Wallet *)wallet context:(NSManagedObjectContext *)context {
    self.amount = wallet.amount.doubleValue;
    
    var currency = [ManagedCurrency currencyInsertIntoContext:context];
    [currency setCurrency:wallet.currency];
    
    self.currency = currency;
}

@end
