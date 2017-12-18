#import "User.h"
#import "CoreDataHeaders.h"

@interface User (CoreData)

+ (User *)userWithManagedUser:(ManagedUser *)managedUser;

@end
