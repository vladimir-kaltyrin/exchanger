#import <UIKit/UIKit.h>
#import "CurrencyExchangeType.h"
#import "ExchangeMoneyCurrencyViewData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@interface ExchangeMoneyView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong, nullable) void(^onPageChange)(CurrencyExchangeType exchangeType, NSInteger current, NSInteger total);

- (void)focusOnStart;
- (void)updateKeyboardData:(KeyboardData *)keyboardData;
- (void)setViewData:(ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
