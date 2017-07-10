#import <Foundation/Foundation.h>
#import "Sender.h"
#import "Cube.h"

@interface Envelope : NSObject
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) Sender *sender;
@property (nonatomic, strong) NSArray<Cube *> *cubes;
@end
