#import <UIKit/UIKit.h>
#import "GalleryPreviewData.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"

@class ExchangeMoneyCurrencyViewData;

@interface ExchangeMoneyCurrencyView : UIView

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder not available")));

- (instancetype)initWithCurrencyExchangeType:(CurrencyExchangeType)exchangeType;

- (void)updateWithModel:(GalleryPreviewData *)model;

- (void)setOnPageChange:(void(^)(CurrencyExchangeType exchangeType, NSInteger current))onPageChange;

- (void)setRemainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle;

@end
