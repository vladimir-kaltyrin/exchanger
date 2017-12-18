#import "Currency.h"
#import "CoreDataHeaders.h"

@interface Currency (CoreData)

+ (Currency *)currencyWithManagedCurrency:(ManagedCurrency *)managedCurrency;

@end
