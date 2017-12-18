#import "UserDataStorageImpl.h"
#import "CoreDataHeaders.h"
#import "ConvenientObjC.h"

@interface UserDataStorageImpl()
@property (nonatomic, strong) CoreDataStack *coreDataStack;
@end

@implementation UserDataStorageImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        let libraryDirectoryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        let savedUserPath = [((NSString *)libraryDirectoryPath) stringByAppendingPathComponent:@"userdata.db"];
        let storeUrl = [NSURL fileURLWithPath:savedUserPath];
        
        self.coreDataStack = [[CoreDataStack alloc] initWithModelName:@"model"
                                                             storeUrl:storeUrl];
        
    }
    return self;
}

- (void)saveUser:(User *)user {
    
}

- (void)savedUser:(OnUser)onUser {
    
}

@end
