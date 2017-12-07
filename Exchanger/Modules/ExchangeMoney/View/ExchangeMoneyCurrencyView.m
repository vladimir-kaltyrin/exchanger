#import "ExchangeMoneyCurrencyView.h"
#import "GalleryPreviewView.h"
#import "GalleryPreviewData.h"
#import "UIView+Properties.h"
#import "CurrencyRateCell.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyCurrencyView()
@property (nonatomic, strong) GalleryPreviewView *previewView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation ExchangeMoneyCurrencyView

// MARK: - Init

- (instancetype)initWithStyle:(ExchangeMoneyCurrencViewStyle)style
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupWithStyle:style];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - Private methods

- (void)setupWithStyle:(ExchangeMoneyCurrencViewStyle)style
{
    self.previewView = [[GalleryPreviewView alloc] initWithFrame:CGRectZero];
    
    UIBlurEffectStyle blurEffectStyle;
    switch (style) {
        case ExchangeMoneyCurrencViewStyleSource:
            blurEffectStyle = UIBlurEffectStyleLight;
            break;
        case ExchangeMoneyCurrencViewStyleTarget:
            blurEffectStyle = UIBlurEffectStyleDark;
            break;
    }
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:blurEffectStyle]];
    
    [self addSubview:self.visualEffectView];
    [self addSubview:self.previewView];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)updateWithModel:(GalleryPreviewData *)model {
    [self.previewView setViewData:model];
}

- (void)setOnPageChange:(void(^)(NSInteger current))onPageChange {
    [self.previewView setOnPageChange:onPageChange];
}

- (void)setCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType {
    
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.visualEffectView.frame = self.bounds;
    self.previewView.frame = self.bounds;
}

@end
