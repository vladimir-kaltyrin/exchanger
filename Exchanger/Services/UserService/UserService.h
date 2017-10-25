#import <Foundation/Foundation.h>
#import "User.h"

@protocol UserService <NSObject>

- (void)currentUser:(void(^)(User *))onCurrenUser;

- (void)updateUser:(User *)user onUpdate:(void(^)())onUpdate;

@end
