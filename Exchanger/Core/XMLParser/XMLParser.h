#import <Foundation/Foundation.h>

@protocol XMLParser <NSObject>
- (void)parse:(NSData *)data onComplete:(void(^)(NSDictionary *))onComplete;
@end
