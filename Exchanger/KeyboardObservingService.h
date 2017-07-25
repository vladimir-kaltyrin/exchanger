#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol KeyboardObservingService <NSObject>
@property (nonatomic, strong) void(^onKeyboardSize)(CGSize);
@end
