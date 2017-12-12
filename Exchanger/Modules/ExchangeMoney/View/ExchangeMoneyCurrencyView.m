#import "ExchangeMoneyCurrencyView.h"
#import "CarouselView.h"
#import "CarouselData.h"
#import "UIView+Properties.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyCurrencyView()
@property (nonatomic, strong) CarouselView *previewView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CurrencyExchangeType exchangeType;
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
    
    self.previewView = [[CarouselView alloc] initWithFrame:CGRectZero];
    
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
    [self addSubview:self.previewView];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

// MARK: - Public

- (void)updateWithModel:(CarouselData *)model {
    [self.previewView setViewData:model];
}

- (void)setOnPageChange:(void(^)(CurrencyExchangeType exchangeType, NSInteger current))onPageChange {
    __weak typeof(self) weakSelf = self;
    [self.previewView setOnPageChange:^(NSInteger current) {
        weakSelf.currentPage = current;
        block(onPageChange, weakSelf.exchangeType, current);
    }];
}

- (void)setOnPageDidAppear:(void (^)())onPageDidAppear {
    [self.previewView setOnPageDidAppear:onPageDidAppear];
}

- (void)setOnPageWillChange:(void (^)())onPageWillChange {
    [self.previewView setOnPageWillChange:onPageWillChange];
}

- (void)focus {
    [self.previewView focus];
}

- (void)setOnFocus:(void (^)())onFocus {
    [self.previewView setOnFocus:onFocus];
}

- (void)setFocusEnabled:(BOOL)focusEnabled {
    [self.previewView setFocusEnabled:focusEnabled];
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.visualEffectView.frame = self.bounds;
    self.previewView.frame = self.bounds;
}

@end
