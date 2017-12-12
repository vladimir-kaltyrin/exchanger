#import <UIKit/UIKit.h>
#import "CurrencyExchangeType.h"
#import "CarouselData.h"
#import "CarouselPageData.h"

@class ExchangeMoneyCurrencyViewData;

@interface ExchangeMoneyCurrencyView : UIView

@property (nonatomic, strong, nullable) void(^onPageDidAppear)();
@property (nonatomic, strong, nullable) void(^onPageWillChange)();
@property (nonatomic, strong) void(^ _Nullable onFocus)();

- (instancetype _Nonnull )init __attribute__((unavailable("init not available")));

- (instancetype _Nonnull )initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (instancetype _Nonnull )initWithCoder:(NSCoder *_Nullable)aDecoder __attribute__((unavailable("initWithCoder not available")));

- (instancetype _Nonnull )initWithCurrencyExchangeType:(CurrencyExchangeType)exchangeType;

- (void)updateWithModel:(CarouselData *_Nonnull)model;

- (void)focus;

- (void)setOnPageChange:(void(^_Nullable)(CurrencyExchangeType exchangeType, NSInteger current))onPageChange;

- (void)setFocusEnabled:(BOOL)focusEnabled;

@end
