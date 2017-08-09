#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class KeyboardData;

@protocol KeyboardObserver <NSObject>
@property (nonatomic, strong) void(^onKeyboardData)(KeyboardData *);
@end
