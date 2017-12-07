#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "CurrencyExchangeType.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong, nullable) void(^onExchangeTap)();
@property (nonatomic, strong, nullable) void(^onBackTap)();

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;
- (void)setExchangeSourceCurrency:(NSString *)sourceCurrency targetCurrency:(NSString *)targetCurrency;
- (void)focusOnStart;
- (void)updateKeyboardData:(nullable KeyboardData *)keyboardData;
- (void)setViewData:(nullable ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
