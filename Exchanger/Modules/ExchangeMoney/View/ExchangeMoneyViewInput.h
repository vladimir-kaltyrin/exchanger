#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "CurrencyExchangeType.h"
#import "Currency.h"
#import "CarouselPageData.h"

typedef void(^OnExchangeTypeChange)(CurrencyExchangeType);

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong, nullable) void(^onExchangeTap)();
@property (nonatomic, strong, nullable) void(^onCancelTap)();

- (void)setOnExchangeTypeChange:(OnExchangeTypeChange _Nullable)onExchangeTypeChange;

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;

- (void)setExchangeSourceCurrency:(Currency *)sourceCurrency targetCurrency:(Currency *)targetCurrency;

- (void)focusOnStart;

- (void)updateKeyboardData:(nullable KeyboardData *)keyboardData;

- (void)setViewData:(nullable ExchangeMoneyViewData *)viewData;

- (void)startActivity;

- (void)stopActivity;

- (void)setExchangeButtonEnabled:(BOOL)enabled;

- (void)setActiveCurrencyExchangeType:(CurrencyExchangeType)exchangeType;

@end
