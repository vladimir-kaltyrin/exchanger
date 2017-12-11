#import "ExchangeMoneyCurrencyView.h"
#import "GalleryPreviewView.h"
#import "GalleryPreviewData.h"
#import "UIView+Properties.h"
#import "SafeBlocks.h"
#import "UIView+Debug.h"

@interface ExchangeMoneyCurrencyView()
@property (nonatomic, strong) GalleryPreviewView *previewView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CurrencyExchangeType exchangeType;
@property (nonatomic, strong) UITextField *firstResponderTextField;
@end

@implementation ExchangeMoneyCurrencyView

// MARK: - Init

- (instancetype)initWithCurrencyExchangeType:(CurrencyExchangeType)exchangeType
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupWithCurrencyExchangeType:exchangeType];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - Private methods

- (void)setupWithCurrencyExchangeType:(CurrencyExchangeType)exchangeType
{
    self.exchangeType = exchangeType;
    
    self.previewView = [[GalleryPreviewView alloc] initWithFrame:CGRectZero];
    
    UIBlurEffectStyle blurEffectStyle;
    switch (exchangeType) {
        case CurrencyExchangeSourceType:
            blurEffectStyle = UIBlurEffectStyleLight;
            break;
        case CurrencyExchangeTargetType:
            blurEffectStyle = UIBlurEffectStyleDark;
            break;
    }
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:blurEffectStyle]];
    
    [self addSubview:self.visualEffectView];
    [self addSubview:self.firstResponderTextField];
    [self addSubview:self.previewView];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    __weak typeof(self) weakSelf = self;
}

// MARK: - Public

- (void)updateWithModel:(GalleryPreviewData *)model {
    [self.previewView setViewData:model];
}

- (void)setOnPageChange:(void(^)(CurrencyExchangeType exchangeType, NSInteger current))onPageChange {
    __weak typeof(self) weakSelf = self;
    [self.previewView setOnPageChange:^(NSInteger current) {
        weakSelf.currentPage = current;
        block(onPageChange, weakSelf.exchangeType, current);
    }];
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.visualEffectView.frame = self.bounds;
    self.previewView.frame = self.bounds;
}

@end
