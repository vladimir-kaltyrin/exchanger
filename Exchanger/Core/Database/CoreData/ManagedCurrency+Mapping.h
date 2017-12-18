#import "ManagedCurrency+CoreDataClass.h"
#import "Currency.h"

@interface ManagedCurrency (Mapping)

+ (ManagedCurrency *)currencyInsertIntoContext:(NSManagedObjectContext *)context;

- (void)setCurrency:(Currency *)currency;

@end
