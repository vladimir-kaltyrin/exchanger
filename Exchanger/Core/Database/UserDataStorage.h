#import "User.h"

typedef void(^OnUser)(User *);

@protocol UserDataStorage

- (void)saveUser:(User *)user;

- (void)savedUser:(OnUser)onUser;

@end
