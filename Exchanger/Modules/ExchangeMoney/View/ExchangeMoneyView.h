#import <UIKit/UIKit.h>
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"

@class KeyboardData;
@class ExchangeMoneyViewData;

@interface ExchangeMoneyView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInsets;

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange;
- (void)setOnInputChange:(void (^)(NSNumber *))onInputChange;

- (void)focusOnStart;
- (void)updateKeyboardData:(nonnull KeyboardData *)keyboardData;
- (void)setViewData:(nonnull ExchangeMoneyViewData *)viewData;
- (void)startActivity;
- (void)stopActivity;
@end
