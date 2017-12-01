#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "CurrencyExchangeType.h"
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong) void(^onExchangeTap)();
@property (nonatomic, strong) void(^onBackTap)();
@property (nonatomic, strong, nullable) void(^onPageChange)(CurrencyExchangeType exchangeType, NSInteger current, NSInteger total);

- (void)setNavigationTitle:(NSString *)title;
- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setViewData:(ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
