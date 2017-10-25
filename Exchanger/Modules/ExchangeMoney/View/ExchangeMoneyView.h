#import <UIKit/UIKit.h>
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;

@interface ExchangeMoneyView : UIView
@property (nonatomic, strong) void(^onCurrencyShown)();
@property (nonatomic, assign) UIEdgeInsets contentInsets;
- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
