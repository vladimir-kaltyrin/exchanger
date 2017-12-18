#import "Currency+CoreData.h"
#import "ConvenientObjC.h"

@implementation Currency (CoreData)

+ (Currency *)currencyWithManagedCurrency:(ManagedCurrency *)managedCurrency {
    var result = [[Currency alloc] init];
    result.currencyType = managedCurrency.currencyType;
    result.rate = [NSNumber numberWithDouble:managedCurrency.rate];
    
    return result;
}

@end
