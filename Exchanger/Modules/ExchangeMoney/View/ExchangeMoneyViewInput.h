#import <Foundation/Foundation.h>
#import "ViewLifeCycleObservable.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@protocol ExchangeMoneyViewInput <ViewLifeCycleObservable>
@property (nonatomic, strong, nullable) void(^onExchangeTap)();
@property (nonatomic, strong, nullable) void(^onBackTap)();

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;
- (void)setExchangeSourceCurrency:(NSString *)sourceCurrency targetCurrency:(NSString *)targetCurrency;
- (void)setOnInputChange:(void (^)(NSNumber *))onInputChange;
- (void)focusOnStart;
- (void)updateKeyboardData:(nullable KeyboardData *)keyboardData;
- (void)setViewData:(nullable ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
- (void)setExchangeButtonEnabled:(BOOL)enabled;

@end
