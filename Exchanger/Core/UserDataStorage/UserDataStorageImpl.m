#import "UserDataStorageImpl.h"
#import "CoreDataHeaders.h"
#import "ConvenientObjC.h"
#import "User+CoreData.h"

typedef void(^OnDeleteUser)();

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
        
        [self deleteUser:^{
            [ManagedUser userWithUser:user insertInContext:context];
            
            [context saveToPersistentStoreWithCompletion:nil];
        }];
    }];
    
}

- (void)user:(OnUser)onUser {
    
    let context = self.coreDataStack.newChildContext;
    if (context == nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            safeBlock(onUser, nil);
        });
        return;
    }
    
    [context performBlock:^{
        
        let request = [[NSFetchRequest alloc] initWithEntityName:@"ManagedUser"];
        
        NSError *error;
        NSArray<ManagedUser *> *savedUsers = [context executeFetchRequest:request error:&error];
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                safeBlock(onUser, nil);
            });
            return;
        }
        
        User *user;
        if (savedUsers.count > 0) {
            let managedUser = savedUsers.firstObject;
            user = [User userWithManagedUser:managedUser];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            safeBlock(onUser, user);
        });
    }];

}

// MARK: - Private

- (void)deleteUser:(OnDeleteUser)onDeleteUser {
    
    let context = self.coreDataStack.newChildContext;
    if (context == nil) {
        safeBlock(onDeleteUser);
        return;
    }
    
    [context performBlock:^{
        
        let request = [[NSFetchRequest alloc] initWithEntityName:@"ManagedUser"];
        
        NSError *error;
        NSArray<ManagedUser *> *savedUsers = [context executeFetchRequest:request error:&error];
        
        if (error) {
            safeBlock(onDeleteUser);
            return;
        }
        
        for (ManagedUser *user in savedUsers) {
            [context deleteObject:user];
        }
        
        safeBlock(onDeleteUser);
        
        [context saveToPersistentStoreWithCompletion:nil];
    }];
}

@end
