#import "ExchangeMoneyViewController.h"
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
@property (nonatomic, strong) BarButton *resetBarButton;
@end

@implementation ExchangeMoneyViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exchangeMoneyView = [[ExchangeMoneyView alloc] init];
        self.exchangeBarButton = [[BarButton alloc] initWithTitle:@"Exchange"];
        self.resetBarButton = [[BarButton alloc] initWithTitle:@"Reset"];
        
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
    self.navigationItem.leftBarButtonItem = self.resetBarButton.barButtonItem;
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

- (void)setOnResetTap:(void (^)())onResetTap {
    self.resetBarButton.onBarButtonTap = onResetTap;
}

- (void (^)())onResetTap {
    return self.resetBarButton.onBarButtonTap;
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
