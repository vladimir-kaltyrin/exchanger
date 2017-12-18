#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

- (instancetype)initWithModelName:(NSString *)modelName
                         storeUrl:(NSURL *)storeUrl;

- (instancetype)initWithModelName:(NSString *)modelName
                         storeUrl:(NSURL *)storeUrl
                           bundle:(NSBundle *)bundle
                        storeType:(NSString *)storeType;

- (void)removeAllStoresWithError:(NSError *)error;

- (NSManagedObjectContext *)primaryContext;

- (NSManagedObjectContext *)newChildContext;

@end
