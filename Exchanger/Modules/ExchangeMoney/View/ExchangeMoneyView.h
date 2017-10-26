#import <UIKit/UIKit.h>
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@interface ExchangeMoneyView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInsets;
- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setViewData:(ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
