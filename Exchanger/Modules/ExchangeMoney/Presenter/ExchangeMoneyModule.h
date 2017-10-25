#import <Foundation/Foundation.h>

@protocol ExchangeMoneyModule <NSObject>
@property (nonatomic, strong) void(^onFinish)();
@end
