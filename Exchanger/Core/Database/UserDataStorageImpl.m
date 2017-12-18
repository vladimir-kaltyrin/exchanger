#import "UserDataStorageImpl.h"
#import "CoreDataHeaders.h"
#import "ConvenientObjC.h"
#import "User+CoreData.h"

@interface UserDataStorageImpl()
@property (nonatomic, strong) CoreDataStack *coreDataStack;
@end

@implementation UserDataStorageImpl

// MARK: - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        let libraryDirectoryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        let savedUserPath = [((NSString *)libraryDirectoryPath.firstObject) stringByAppendingPathComponent:@"userdata.db"];
        let storeUrl = [NSURL fileURLWithPath:savedUserPath];
        
        self.coreDataStack = [[CoreDataStack alloc] initWithModelName:@"model"
                                                             storeUrl:storeUrl];
        
    }
    return self;
}

// MARK: - Public

- (void)saveUser:(User *)user {
    
    let context = self.coreDataStack.newChildContext;
    if (context == nil) {
        return;
    }
    
    [context performBlock:^{
        
        [ManagedUser userWithUser:user insertInContext:context];
        
        [context saveToPersistentStoreWithCompletion:nil];
    }];
    
}

- (void)user:(OnUser)onUser {
    
    let context = self.coreDataStack.newChildContext;
    if (context == nil) {
        safeBlock(onUser, nil);
        return;
    }
    
    [context performBlock:^{
        
        let request = [[NSFetchRequest alloc] initWithEntityName:@"ManagedUser"];
        
        NSError *error;
        let savedUsers = [context executeFetchRequest:request error:&error];
        
        if (error) {
            safeBlock(onUser, nil);
            return;
        }
        
        let managedUser = savedUsers.firstObject;
        let user = [User userWithManagedUser:managedUser];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            safeBlock(onUser, user);
        });
    }];

}

// MARK: - Private

@end
