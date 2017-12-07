#import <UIKit/UIKit.h>
#import "GalleryPreviewData.h"
#import "CurrencyExchangeType.h"

@class ExchangeMoneyCurrencyViewData;

typedef NS_ENUM(NSInteger, ExchangeMoneyCurrencViewStyle) {
    ExchangeMoneyCurrencViewStyleSource,
    ExchangeMoneyCurrencViewStyleTarget
};

@interface ExchangeMoneyCurrencyView : UIView

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder not available")));

- (instancetype)initWithStyle:(ExchangeMoneyCurrencViewStyle)style;

- (void)updateWithModel:(GalleryPreviewData *)model;

- (void)setOnPageChange:(void(^)(NSInteger current))onPageChange;

- (void)setCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType;

@end
