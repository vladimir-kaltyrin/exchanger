#import "NSManagedObjectContext+CoreDataManagement.h"
#import "ConvenientObjC.h"

@implementation NSManagedObjectContext (CoreDataManagement)

- (void)saveToPersistentStoreWithCompletion:(OnPersistentStoreSave)completion {
    if (self.hasChanges == false) {
        if (completion != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
        }
        return;
    }
    
    [self performBlock:^{
        NSError *error;
        [self save:&error];
        
        let parentContext = self.parentContext;
        if (parentContext != nil) {
            [parentContext saveToPersistentStoreWithCompletion:completion];
        } else {
            if (completion != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(YES);
                });
            }
            return;
        }
        
        if (error) {
            NSLog(@"Error saving context: %@", error);
            if (completion != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(NO);
                });
            }
            return;
        }
        
    }];
}

- (BOOL)saveToPersistentStoreAndWait {
    
    if (self.hasChanges == false) {
        return YES;
    }
    
    __block var success = YES;
    
    [self performBlockAndWait:^{
        NSError *error;
        
        [self save:&error];
        
        let parentContext = self.parentContext;
        if (parentContext != nil) {
            success = [parentContext saveToPersistentStoreAndWait];
        } else {
            NSLog(@"Error saving context: %@", error);
            success = NO;
        }
    }];
    
    return success;
}

@end
