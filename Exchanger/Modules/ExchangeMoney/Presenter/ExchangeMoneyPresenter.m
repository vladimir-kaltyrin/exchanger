#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "KeyboardObserver.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) id<ExchangeMoneyInteractor> interactor;
@property (nonatomic, strong) id<ExchangeMoneyRouter> router;
@property (nonatomic, strong) id<KeyboardObserver> keyboardObserver;
@end

@implementation ExchangeMoneyPresenter
@synthesize onFinish;

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
    
    [self.view setOnExchangeTap:^{
        
    }];
    
    [self.view setOnCancelTap:^{
        executeIfNotNil(weakSelf.onFinish);
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf updateExchangeRates:data onUpdate:nil];
        [weakSelf updateNavigationTitleRate:nil];
    }];
    
    [self.interactor startFetching];
}

- (void)updateNavigationTitleRate:(void(^)())onUpdate {
    __weak typeof(self) weakSelf = self;
    [self.interactor convertedCurrency:^(Currency *convertedCurrency) {
        NSString *sourceCurrencySign = [weakSelf.interactor sourceCurrency].currencySign;
        NSString *convertedCurrencySign = convertedCurrency.currencySign;
        NSString *currentRate = [NSString stringWithFormat:@"1%@- %.5f%@",
                                 sourceCurrencySign,
                                 convertedCurrency.rate.floatValue,
                                 convertedCurrencySign
                                 ];
        [weakSelf.view setNavigationTitle:currentRate];
        executeIfNotNil(onUpdate);
    }];
}

- (void)updateExchangeRates:(ExchangeRatesData *)ratesData onUpdate:(void(^)())onUpdate {
    
    __weak typeof(self) weakSelf = self;
    
    [self.interactor fetchUser:^(User *user) {
        NSArray *sourceViewDataList = [weakSelf sourceCurrencyViewDataListWithUser:user exchangeRates:ratesData];
        NSArray *targetViewDataList = [weakSelf targetCurrencyViewDataListWithUser:user exchangeRates:ratesData];
        
        [weakSelf.view setSourceCurrencyViewData:sourceViewDataList];
        [weakSelf.view setTargetCurrencyViewData:targetViewDataList];
        
        executeIfNotNil(onUpdate);
    }];
}

- (void)showTitle {
    [self.interactor exchange:^(MoneyData *moneyData) {
        
    }];
}

- (NSArray<ExchangeMoneyCurrencyViewData *> *)sourceCurrencyViewDataListWithUser:(User *)user
                                                                   exchangeRates:(ExchangeRatesData *)ratesData
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *viewDatas = [NSMutableArray array];
    for (Currency *currency in ratesData.currencies) {
        ExchangeMoneyCurrencyViewData *viewData = [[ExchangeMoneyCurrencyViewData alloc] init];
        viewData.currency = [currency currencyCode];
        
        ExchangeMoneyBalanceViewData *balanceViewData = [[ExchangeMoneyBalanceViewData alloc] init];
        balanceViewData.balanceValue = [self balanceWithUser:user
                                                currencyType:currency.currencyType];
        
        viewData.balance = balanceViewData;
        
        [viewData setOnShow:^{
            [weakSelf.interactor setSourceCurrency:currency];
            [weakSelf updateNavigationTitleRate:nil];
        }];
        
        [viewDatas addObject:viewData];
    }
    return viewDatas;
}

- (NSArray<ExchangeMoneyCurrencyViewData *> *)targetCurrencyViewDataListWithUser:(User *)user
                                                                   exchangeRates:(ExchangeRatesData *)ratesData {
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *viewDatas = [NSMutableArray array];
    for (Currency *currency in ratesData.currencies) {
        ExchangeMoneyCurrencyViewData *viewData = [[ExchangeMoneyCurrencyViewData alloc] init];
        viewData.currency = [currency currencyCode];
        viewData.rate = currency.rate.stringValue;
        
        ExchangeMoneyBalanceViewData *balanceViewData = [[ExchangeMoneyBalanceViewData alloc] init];
        balanceViewData.balanceValue = [self balanceWithUser:user
                                                currencyType:currency.currencyType];
        
        viewData.balance = balanceViewData;
        
        [viewData setOnShow:^{
            [weakSelf.interactor setTargetCurrency:currency];
            [weakSelf updateNavigationTitleRate:nil];
        }];
        
        [viewDatas addObject:viewData];
    }
    return viewDatas;
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    MoneyData *moneyData = [user moneyDataWithCurrencyType:currencyType];
    return [NSString stringWithFormat:@"You have %@", [moneyData.amount stringValue]];
}

@end
