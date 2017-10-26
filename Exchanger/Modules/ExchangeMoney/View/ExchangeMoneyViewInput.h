#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong) void(^onExchangeTap)();
@property (nonatomic, strong) void(^onResetTap)();

- (void)setNavigationTitle:(NSString *)title;
- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setViewData:(ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
