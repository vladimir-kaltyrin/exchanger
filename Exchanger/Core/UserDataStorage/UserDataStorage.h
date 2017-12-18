#import "User.h"

typedef void(^OnUser)(User *);

@protocol UserDataStorage

- (void)saveUser:(User *)user;

- (void)user:(OnUser)onUser;

@end
