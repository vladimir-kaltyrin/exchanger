#import <CoreData/CoreData.h>

typedef void(^OnPersistentStoreSave)(BOOL);

@interface NSManagedObjectContext (CoreDataManagement)

- (void)saveToPersistentStoreWithCompletion:(OnPersistentStoreSave)completion;

- (BOOL)saveToPersistentStoreAndWait;

@end
