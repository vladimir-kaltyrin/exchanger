#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong) void(^onExchangeTap)();
@property (nonatomic, strong) void(^onCancelTap)();

- (void)setNavigationTitle:(NSString *)title;
- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
