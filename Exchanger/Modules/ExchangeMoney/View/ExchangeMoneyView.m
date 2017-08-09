#import "ExchangeMoneyView.h"
#import "ExchangeMoneyPageViewController.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "KeyboardData.h"
#import "UIView+Properties.h"

@interface ExchangeMoneyView()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) ExchangeMoneyPageViewController *sourceExchangeView;
@property (nonatomic, strong) ExchangeMoneyPageViewController *targetExchangeView;
@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation ExchangeMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        self.sourceExchangeView = [[ExchangeMoneyPageViewController alloc] init];
        self.sourceExchangeView.view.backgroundColor = [UIColor redColor];
        
        self.targetExchangeView = [[ExchangeMoneyPageViewController alloc] init];
        self.targetExchangeView.view.backgroundColor = [UIColor blueColor];
        
        [self addSubview:self.sourceExchangeView.view];
        [self addSubview:self.targetExchangeView.view];
        [self addSubview:self.activityIndicator];
    }
    
    return self;
}

// MARK: - ExchangeMoneyView

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    self.contentHeight = keyboardData.size.height;
    [self setNeedsLayout];
}

- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    self.sourceExchangeView.viewData = viewData;
}

- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    self.targetExchangeView.viewData = viewData;
}

- (void)startActivity {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivity {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.contentHeight ? self.bounds.size.height : self.contentHeight;
    
    self.sourceExchangeView.view.height = height / 2;
    
    self.targetExchangeView.view.top = self.sourceExchangeView.view.bottom;
    self.targetExchangeView.view.height = height / 2;
    
    self.activityIndicator.center = self.center;
}

@end
