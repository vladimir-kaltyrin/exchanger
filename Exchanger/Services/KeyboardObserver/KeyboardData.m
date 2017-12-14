#import "KeyboardData.h"

@interface KeyboardData()
@property (nonatomic, assign) CGSize size;
@end

@implementation KeyboardData

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super init]) {
        self.size = size;
    }
    return self;
}

@end
