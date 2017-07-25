#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "ExchangeMoneyCurrencyViewData.h"

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>

- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData;
- (void)startActivity;
- (void)stopActivity;

@end
