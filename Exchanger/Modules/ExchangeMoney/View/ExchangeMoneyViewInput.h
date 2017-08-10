#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>

- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
