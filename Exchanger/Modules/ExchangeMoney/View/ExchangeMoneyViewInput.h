#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "CurrencyExchangeType.h"
#import "Currency.h"
#import "GalleryPreviewPageData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong, nullable) void(^onExchangeTap)();
@property (nonatomic, strong, nullable) void(^onCancelTap)();

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;
- (void)setExchangeSourceCurrency:(Currency *)sourceCurrency targetCurrency:(Currency *)targetCurrency;
- (void)setOnInputChange:(void (^)(NSString *))onInputChange;
- (void)focusOnStart;
- (void)updateKeyboardData:(nullable KeyboardData *)keyboardData;
- (void)setViewData:(nullable ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
- (void)setExchangeButtonEnabled:(BOOL)enabled;

@end
