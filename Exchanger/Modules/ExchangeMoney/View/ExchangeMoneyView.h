#import <UIKit/UIKit.h>
#import "CurrencyExchangeType.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@interface ExchangeMoneyView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInsets;

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;

- (void)focusOnStart;
- (void)updateKeyboardData:(nonnull KeyboardData *)keyboardData;
- (void)setViewData:(nonnull ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
