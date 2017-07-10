#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Cube : NSObject
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<Currency *> *items;
@end
