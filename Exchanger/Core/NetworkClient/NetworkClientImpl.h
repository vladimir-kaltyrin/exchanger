#import <Foundation/Foundation.h>
#import "NetworkClient.h"
#import "XMLParser.h"

@interface NetworkClientImpl : NSObject<NetworkClient>

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithParser:(id<XMLParser>)parser;

@end
