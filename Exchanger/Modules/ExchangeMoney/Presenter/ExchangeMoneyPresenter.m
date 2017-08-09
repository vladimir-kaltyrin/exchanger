#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "KeyboardObserver.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) id<ExchangeMoneyInteractor> interactor;
@property (nonatomic, strong) id<ExchangeMoneyRouter> router;
@property (nonatomic, strong) id<KeyboardObserver> keyboardObserver;
@end

@implementation ExchangeMoneyPresenter

- (instancetype)initWithInteractor:(id<ExchangeMoneyInteractor>)interactor
                            router:(id<ExchangeMoneyRouter>)router
                  keyboardObserver:(id<KeyboardObserver>)keyboardObserver;
{
    self = [super init];
    if (self) {
        self.interactor = interactor;
        self.router = router;
        self.keyboardObserver = keyboardObserver;
    }
    
    return self;
}

- (void)setView:(id<ExchangeMoneyViewInput>)view {
    _view = view;
    
    [self setUpView];
}

// MARK: - Private

- (void)setUpView {
    
    __weak typeof(self) weakSelf = self;
    
    [self.keyboardObserver setOnKeyboardData:^(KeyboardData *keyboardData) {
        [weakSelf.view updateKeyboardData:keyboardData];
    }];
    
    [self.view setOnViewDidLoad:^{
        [weakSelf.view startActivity];
        [weakSelf.interactor startFetching];
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf updateExchangeRates:data];
    }];
}

- (void)updateExchangeRates:(ExchangeRatesData *)data {
    NSMutableArray *viewDatas = [NSMutableArray array];
    for (Currency *currency in data.currencies) {
        ExchangeMoneyCurrencyViewData *viewData = [[ExchangeMoneyCurrencyViewData alloc] init];
        viewData.currency = [currency currencyTypeToString];
        viewData.rate = currency.rate.stringValue;
        
        [viewDatas addObject:viewData];
    }
    
    [self.view setSourceCurrencyViewData:viewDatas];
    [self.view setTargetCurrencyViewData:viewDatas];
}

@end
