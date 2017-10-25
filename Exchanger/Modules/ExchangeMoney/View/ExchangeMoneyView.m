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
@property (nonatomic, assign) CGFloat keyboardHeight;
@end

@implementation ExchangeMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        self.sourceExchangeView = [[ExchangeMoneyPageViewController alloc] init];
        self.sourceExchangeView.view.backgroundColor = [UIColor colorWithRed:33
                                                                       green:33
                                                                        blue:33
                                                                       alpha:1];
        
        self.targetExchangeView = [[ExchangeMoneyPageViewController alloc] init];
        self.targetExchangeView.view.backgroundColor = [UIColor colorWithRed:11
                                                                       green:11
                                                                        blue:11
                                                                       alpha:1];
        
        [self addSubview:self.sourceExchangeView.view];
        [self addSubview:self.targetExchangeView.view];
        [self addSubview:self.activityIndicator];
    }
    
    return self;
}

// MARK: - ExchangeMoneyView

- (void)setOnCurrencyShown:(void (^)())onCurrencyShown {
    [self.sourceExchangeView setOnPageShown:onCurrencyShown];
}

- (void (^)())onCurrencyShown {
    return [self.sourceExchangeView onPageShown];
}

- (void)focusOnStart {
    [self.sourceExchangeView becomeFirstResponder];
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    self.keyboardHeight = keyboardData.size.height;
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
    
    CGFloat height = self.bounds.size.height - self.contentInsets.top - self.keyboardHeight;
    
    self.sourceExchangeView.view.height = height / 2;
    self.sourceExchangeView.view.width = self.bounds.size.width;
    
    self.targetExchangeView.view.top = self.sourceExchangeView.view.bottom;
    self.targetExchangeView.view.height = height / 2;
    self.targetExchangeView.view.width = self.bounds.size.width;
    
    self.activityIndicator.center = self.center;
}

@end
