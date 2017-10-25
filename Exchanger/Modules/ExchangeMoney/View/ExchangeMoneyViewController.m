#import "ExchangeMoneyViewController.h"
#import "ExchangeMoneyView.h"
#import "ExchangeMoneyTitleView.h"
#import "UIViewController+Extensions.h"
#import "BarButton.h"

@class KeyboardData;

@interface ExchangeMoneyViewController ()
@property (nonatomic, strong) ExchangeMoneyView* exchangeMoneyView;
@property (nonatomic, strong) ExchangeMoneyTitleView *exchangeMoneyTitleView;
@property (nonatomic, strong) BarButton *exchangeBarButton;
@property (nonatomic, strong) BarButton *cancelBarButton;
@end

@implementation ExchangeMoneyViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exchangeMoneyView = [[ExchangeMoneyView alloc] init];
        self.exchangeBarButton = [[BarButton alloc] initWithTitle:@"Exchange"];
        self.cancelBarButton = [[BarButton alloc] initWithTitle:@"Cancel"];
        
        self.exchangeMoneyTitleView = [[ExchangeMoneyTitleView alloc] init];
        self.exchangeMoneyTitleView.frame = CGRectMake(0, 0, 150, 36);
    }
    
    return self;
}

- (void)loadView {
    self.view = self.exchangeMoneyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.exchangeBarButton.barButtonItem;
    self.navigationItem.leftBarButtonItem = self.cancelBarButton.barButtonItem;
    self.navigationItem.titleView = self.exchangeMoneyTitleView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.exchangeMoneyView.contentInsets = [self defaultContentInsets];
}

// MARK: - ExchangeMoneyViewInput

- (void)setNavigationTitle:(NSString *)title {
    [self.exchangeMoneyTitleView setTitle:title];
}

- (void)setOnCancelTap:(void (^)())onCancelTap {
    self.cancelBarButton.onBarButtonTap = onCancelTap;
}

- (void (^)())onCancelTap {
    return self.cancelBarButton.onBarButtonTap;
}

- (void)setOnExchangeTap:(void (^)())onExchangeTap {
    self.exchangeBarButton.onBarButtonTap = onExchangeTap;
}

- (void (^)())onExchangeTap {
    return self.exchangeBarButton.onBarButtonTap;
}

- (void)focusOnStart {
    [self.exchangeMoneyView focusOnStart];
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    [self.exchangeMoneyView updateKeyboardData:keyboardData];
}

- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    [self.exchangeMoneyView setSourceCurrencyViewData:viewData];
}

- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    [self.exchangeMoneyView setTargetCurrencyViewData:viewData];
}

- (void)startActivity {
    [self.exchangeMoneyView startActivity];
}

- (void)stopActivity {
    [self.exchangeMoneyView stopActivity];
}

@end
