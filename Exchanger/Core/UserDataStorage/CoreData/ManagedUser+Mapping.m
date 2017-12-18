#import "ManagedUser+Mapping.h"
#import "ManagedWallet+Mapping.h"
#import "ConvenientObjC.h"
#import "User.h"

@implementation ManagedUser (Mapping)

+ (ManagedUser *)userWithUser:(User *)user insertInContext:(NSManagedObjectContext *)context
{
    var managedUser = [ManagedUser userInsertIntoContext:context];
    [managedUser setUser:user context:context];
    
    return managedUser;
}

+ (ManagedUser *)userInsertIntoContext:(NSManagedObjectContext *)context
{
    let entity = [NSEntityDescription entityForName:@"ManagedUser" inManagedObjectContext:context];
    
    return [[ManagedUser alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

- (void)setUser:(User *)user context:(NSManagedObjectContext *)context
{
    var usdWallet = [ManagedWallet walletInsertIntoContext:context];
    [usdWallet setWallet:[user walletWithCurrencyType:CurrencyTypeUSD] context:context];
    self.usdWallet = usdWallet;
    
    var eurWallet = [ManagedWallet walletInsertIntoContext:context];
    [eurWallet setWallet:[user walletWithCurrencyType:CurrencyTypeEUR] context:context];
    self.eurWallet = eurWallet;
    
    var gbpWallet = [ManagedWallet walletInsertIntoContext:context];
    [gbpWallet setWallet:[user walletWithCurrencyType:CurrencyTypeGBP] context:context];
    self.gbpWallet = gbpWallet;
}

@end
