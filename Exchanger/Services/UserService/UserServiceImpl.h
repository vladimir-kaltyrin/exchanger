#import <Foundation/Foundation.h>
#import "UserService.h"
#import "UserDataStorage.h"

@interface UserServiceImpl : NSObject<UserService>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithUserDataStorage:(id<UserDataStorage>)userDataStorage;

@end
