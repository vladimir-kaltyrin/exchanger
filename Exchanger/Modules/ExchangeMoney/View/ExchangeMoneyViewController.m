#import "ExchangeMoneyViewController.h"
#import "CurrencyExchangeType.h"
#import "ExchangeMoneyView.h"
#import "ExchangeMoneyTitleView.h"
#import "ExchangeMoneyViewData.h"
#import "UIViewController+Extensions.h"
#import "BarButton.h"

@class KeyboardData;

@interface ExchangeMoneyViewController ()
@property (nonatomic, strong) ExchangeMoneyView* exchangeMoneyView;
@property (nonatomic, strong) ExchangeMoneyTitleView *exchangeMoneyTitleView;
@property (nonatomic, strong) BarButton *exchangeBarButton;
@property (nonatomic, strong) BarButton *backBarButton;
@end

@implementation ExchangeMoneyViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exchangeMoneyView = [[ExchangeMoneyView alloc] init];
        self.exchangeBarButton = [[BarButton alloc] initWithTitle:@"Exchange"];
        self.backBarButton = [[BarButton alloc] initWithTitle:@"Back"];
        
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
    self.navigationItem.leftBarButtonItem = self.backBarButton.barButtonItem;
    self.navigationItem.titleView = self.exchangeMoneyTitleView;
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

- (void)setNavigationTitle:(NSString *)title {
    [self.exchangeMoneyTitleView setTitle:title];
}

- (void)setOnBackTap:(void (^)())onBackTap {
    self.backBarButton.onBarButtonTap = onBackTap;
}

- (void (^)())onBackTap {
    return self.backBarButton.onBarButtonTap;
}

- (void)setOnExchangeTap:(void (^)())onExchangeTap {
    self.exchangeBarButton.onBarButtonTap = onExchangeTap;
}

- (void (^)())onExchangeTap {
    return self.exchangeBarButton.onBarButtonTap;
}

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger, NSInteger))onPageChange {
    [self.exchangeMoneyView setOnPageChange:onPageChange];
}

- (void (^)(CurrencyExchangeType, NSInteger, NSInteger))onPageChange {
    return [self.exchangeMoneyView onPageChange];
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

@end
