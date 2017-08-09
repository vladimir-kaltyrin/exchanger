#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface KeyboardData : NSObject
@property (nonatomic, assign, readonly) CGSize size;

- (instancetype)initWithSize:(CGSize)size;

@end
