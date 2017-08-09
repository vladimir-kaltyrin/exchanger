#import <UIKit/UIKit.h>
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;

@interface ExchangeMoneyView : UIView
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
