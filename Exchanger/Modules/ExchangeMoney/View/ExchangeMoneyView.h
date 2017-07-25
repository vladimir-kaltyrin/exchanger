#import <UIKit/UIKit.h>
#import "ExchangeMoneyCurrencyViewData.h"

@interface ExchangeMoneyView : UIView
- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
