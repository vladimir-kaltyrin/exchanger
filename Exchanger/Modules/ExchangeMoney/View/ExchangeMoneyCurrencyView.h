#import <UIKit/UIKit.h>
#import "GalleryPreviewData.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"

@class ExchangeMoneyCurrencyViewData;

@interface ExchangeMoneyCurrencyView : UIView

@property (nonatomic, strong, nullable) void(^onPageDidAppear)();
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
@property (nonatomic, strong) void(^onFocus)();

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder not available")));

- (instancetype)initWithCurrencyExchangeType:(CurrencyExchangeType)exchangeType;

- (void)updateWithModel:(GalleryPreviewData *)model;

- (void)focus;

- (void)setOnPageChange:(void(^)(CurrencyExchangeType exchangeType, NSInteger current))onPageChange;

- (void)setRemainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle;

- (void)setFocusEnabled:(BOOL)focusEnabled;

@end
