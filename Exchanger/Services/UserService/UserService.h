#import <Foundation/Foundation.h>
#import "User.h"

@protocol UserService <NSObject>

- (void)currentUser:(void(^)(User *))onCurrenUser;

@end
