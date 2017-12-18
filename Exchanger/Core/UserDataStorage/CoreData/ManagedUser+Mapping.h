#import "ManagedUser+CoreDataClass.h"
#import "User.h"

@interface ManagedUser (Mapping)

+ (ManagedUser *)userWithUser:(User *)user insertInContext:(NSManagedObjectContext *)context;

+ (ManagedUser *)userInsertIntoContext:(NSManagedObjectContext *)context;

- (void)setUser:(User *)user context:(NSManagedObjectContext *)context;

@end
