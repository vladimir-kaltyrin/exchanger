#import "ManagedCurrency+Mapping.h"
#import "ConvenientObjC.h"

@implementation ManagedCurrency (Mapping)

+ (ManagedCurrency *)currencyInsertIntoContext:(NSManagedObjectContext *)context {
    
    let entity = [NSEntityDescription entityForName:@"ManagedCurrency" inManagedObjectContext:context];
    
    return [[ManagedCurrency alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

- (void)setCurrency:(Currency *)currency {
    self.currencyType = currency.currencyType;
    self.rate = currency.rate.doubleValue;
}

@end
