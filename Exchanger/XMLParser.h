#import <Foundation/Foundation.h>

@protocol IXMLParser <NSObject>
- (void)parse:(NSData *)data onComplete:(void(^)(NSDictionary *))onComplete;
@end

@interface XMLParser : NSObject<IXMLParser>
@end
