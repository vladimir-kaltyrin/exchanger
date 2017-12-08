#import "ExchangeMoneyViewController.h"
#import "CurrencyExchangeType.h"
#import "ExchangeMoneyView.h"
#import "ExchangeMoneyTitleView.h"
#import "ExchangeMoneyViewData.h"
#import "UIViewController+Extensions.h"
#import "BarButton.h"

@class KeyboardData;

@interface ExchangeMoneyViewController() <ExchangeMoneyViewInput>
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
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.exchangeMoneyView endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.exchangeMoneyView.contentInsets = [self defaultContentInsets];
}

// MARK: - ExchangeMoneyViewInput

- (void)setExchangeSourceCurrency:(Currency *)sourceCurrency targetCurrency:(Currency *)targetCurrency {
    [self.exchangeMoneyTitleView setExchangeSourceCurrency:sourceCurrency targetCurrency:targetCurrency];
}

- (void)setOnCancelTap:(void (^)())onBackTap {
    self.cancelBarButton.onBarButtonTap = onBackTap;
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

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange {
    [self.exchangeMoneyView setOnPageChange:onPageChange];
}

- (void)focusOnStart {
    [self.exchangeMoneyView focusOnStart];
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    [self.exchangeMoneyView updateKeyboardData:keyboardData];
}

- (void)setViewData:(ExchangeMoneyViewData *)viewData {
    [self.exchangeMoneyView setViewData:viewData];
}

- (void)startActivity {
    [self.exchangeMoneyView startActivity];
}

- (void)stopActivity {
    [self.exchangeMoneyView stopActivity];
}

- (void)setOnInputChange:(void (^)(NSString *))onInputChange {
    [self.exchangeMoneyView setOnInputChange:onInputChange];
}

- (void)setExchangeButtonEnabled:(BOOL)enabled {
    self.exchangeBarButton.barButtonItem.enabled = enabled;
}

@end
