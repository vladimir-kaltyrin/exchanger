#import "ManagedWallet+CoreDataClass.h"
#import "Wallet.h"

@interface ManagedWallet (Mapping)

+ (ManagedWallet *)walletInsertIntoContext:(NSManagedObjectContext *)context;

- (void)setWallet:(Wallet *)wallet context:(NSManagedObjectContext *)context;

@end
