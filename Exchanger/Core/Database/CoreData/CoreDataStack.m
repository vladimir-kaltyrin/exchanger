#import "CoreDataStack.h"
#import "ConvenientObjC.h"

@interface CoreDataStack()
@property (nonatomic, strong, nonnull) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, strong, nonnull) NSManagedObjectContext *primaryManagedObjectContext;
@end

@implementation CoreDataStack

// MARK: - Init

- (instancetype)initWithModelName:(NSString *)modelName
                         storeUrl:(NSURL *)storeUrl
{
    return [self initWithModelName:modelName
                          storeUrl:storeUrl
                            bundle:[NSBundle mainBundle]
                         storeType:NSSQLiteStoreType];
}

- (instancetype)initWithModelName:(NSString *)modelName
                         storeUrl:(NSURL *)storeUrl
                           bundle:(NSBundle *)bundle
                        storeType:(NSString *)storeType
{
    let modelUrl = [bundle URLForResource:modelName withExtension:@"momd"];
    let model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    if (model == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSError *error;
        let options = @{ NSMigratePersistentStoresAutomaticallyOption : @YES,
                         NSInferMappingModelAutomaticallyOption: @YES };
        
        [self.coordinator addPersistentStoreWithType:storeType
                                       configuration:nil
                                                 URL:storeUrl
                                             options:options
                                               error:&error];
        
        if (error != nil) {
            NSLog(@"error adding persistent store to coordinator: %@", error);
            return nil;
        }
        
        self.primaryManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        self.primaryManagedObjectContext.persistentStoreCoordinator = self.coordinator;
    }
    
    return self;
}

// MARK: - Public

- (void)removeAllStoresWithError:(NSError *)error
{
    for (NSPersistentStore *store in [self.coordinator persistentStores]) {
        [self.coordinator removePersistentStore:store error:&error];
    }
}

- (NSManagedObjectContext *)primaryContext {
    return self.primaryManagedObjectContext;
}

- (NSManagedObjectContext *)newChildContext {
    let context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:self.primaryManagedObjectContext];
    return context;
}

@end
