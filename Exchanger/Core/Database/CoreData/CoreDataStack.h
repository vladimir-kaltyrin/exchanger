#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

- (void)removeAllStoresWithError:(NSError *)error;

- (NSManagedObjectContext *)primaryContext;

- (NSManagedObjectContext *)newChildContext;

@end
