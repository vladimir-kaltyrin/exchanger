#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyViewData.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"
#import "GalleryPreviewData.h"
#import "KeyboardObserver.h"
#import "FormatterFactoryImpl.h"
#import "ExchangeMoneyViewDataBuilder.h"
#import "SafeBlocks.h"
#import "Wallet.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) ExchangeRatesData *exchangeRatesData;
@property (nonatomic, assign) CurrencyExchangeType activeExchangeType;
@property (nonatomic, strong) NSString *expenseInput;
@property (nonatomic, strong) NSString *incomeInput;
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
    
    self.activeExchangeType = CurrencyExchangeSourceType;
    
    [self.keyboardObserver setOnKeyboardData:^(KeyboardData *keyboardData) {
        [weakSelf.view updateKeyboardData:keyboardData];
        [weakSelf reloadViewWithUpdateRates:NO];
    }];
    
    [self.view setExchangeButtonEnabled:YES];
    
    [self.view setOnViewDidLoad:^{
        [weakSelf.view startActivity];
        [weakSelf.interactor startFetching];
    }];
    
    [self.view setOnViewWillAppear:^{
        [weakSelf.view focusOnStart];
        [weakSelf.view setActiveCurrencyExchangeType:weakSelf.activeExchangeType];
    }];
    
    [self.view setOnExchangeTypeChange:^(CurrencyExchangeType newExchangeType) {
        weakSelf.activeExchangeType = newExchangeType;
    }];
    
    [self.view setOnExchangeTap:^{
        [weakSelf.interactor exchangeCurrency:@(weakSelf.expenseInput.floatValue)
                                   onExchange:^{
                                       [weakSelf fetchRatesWithRepeat:NO
                                                             onUpdate:nil
                                                              onError:nil];
                                       
                                   } onError:nil];
    }];
    
    // TODO: fix retain-reference cycle
    [self.view setOnCancelTap:^{
        block(self.onFinish);
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf updateViewWithData:data updateRates:YES];
    }];
    
    [self fetchRatesWithRepeat:YES
                      onUpdate:nil
                       onError:nil];
    
    [self.view setOnPageChange:^(CurrencyExchangeType exchangeType, NSInteger current) {
        [weakSelf update:exchangeType withIndex:current];
        [weakSelf reloadViewWithUpdateRates:YES];
    }];
}

- (void)updateViewWithData:(ExchangeRatesData *)data updateRates:(BOOL)updateRates {
    [self updateExchangeButton];
    [self updateNavigationTitleRate:nil];
    if (updateRates) {
        [self updateExchangeRates:data onUpdate:nil];
    }
}

- (void)updateNavigationTitleRate:(void(^)())onUpdate {
    __weak typeof(self) weakSelf = self;
    [self.interactor convertedCurrency:^(Currency *convertedCurrency) {
        Currency *sourceCurrency = [weakSelf.interactor sourceCurrency];

        [weakSelf.view setExchangeSourceCurrency:sourceCurrency targetCurrency:convertedCurrency];
        block(onUpdate);
    }];
}

- (void)updateExchangeRates:(ExchangeRatesData *)ratesData onUpdate:(void(^)())onUpdate {
    
    __weak typeof(self) weakSelf = self;
    
    [self.interactor fetchUser:^(User *user) {
        
        Wallet *inputWallet = [[Wallet alloc] initWithCurrency:weakSelf.interactor.sourceCurrency
                                                        amount:@(self.expenseInput.floatValue)];
        [weakSelf.interactor exchangeWallet:inputWallet
                             targetCurrency:weakSelf.interactor.targetCurrency
                                   onResult:^(Wallet *targetWallet, NSNumber *invertedRate)
        {
            ExchangeMoneyViewDataBuilder *builder = [[ExchangeMoneyViewDataBuilder alloc] initWithUser:user
                                                                                            currencies:ratesData.currencies
                                                                                           incomeInput:self.incomeInput
                                                                                          expenseInput:self.expenseInput
                                                                                        sourceCurrency:self.interactor.sourceCurrency
                                                                                        targetCurrency:self.interactor.targetCurrency
                                                                                          targetWallet:targetWallet
                                                                                          invertedRate:invertedRate
                                                                                         onInputChange:^(NSString *text, CurrencyExchangeType exchangeType) {
                                                                                             switch (exchangeType) {
                                                                                                 case CurrencyExchangeSourceType:
                                                                                                     weakSelf.expenseInput = text;
                                                                                                     break;
                                                                                                 case CurrencyExchangeTargetType:
                                                                                                     weakSelf.incomeInput = text;
                                                                                                     break;
                                                                                             }
                                                                                             
                                                                                             [weakSelf reloadView];
                                                                                         }];
            
            ExchangeMoneyViewData *viewData = [builder build];
            
            [weakSelf.view setViewData:viewData];
            
            block(onUpdate);
        }];
    }];
}

- (void)fetchRatesWithRepeat:(BOOL)repeat onUpdate:(void(^)())onUpdate onError:(void (^)(NSError *))onError {
    [self.view startActivity];
    
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchRates:^(ExchangeRatesData *data) {
        weakSelf.exchangeRatesData = data;
        [weakSelf.view stopActivity];
        [weakSelf.interactor resetCurrenciesWithData:data onReset:^{
            [weakSelf reloadView];
            if (repeat) {
                [weakSelf.interactor startFetching];
            }
            block(onUpdate)
        }];
    } onError:onError];
}

- (void)update:(CurrencyExchangeType)exchangeType withIndex:(NSInteger)index {
    
    if ((index) < 0 || (index >= self.exchangeRatesData.currencies.count)) {
        return;
    }
    
    switch (exchangeType) {
        case CurrencyExchangeSourceType:
            self.interactor.sourceCurrency = self.exchangeRatesData.currencies[index];
            break;
        case CurrencyExchangeTargetType:
            self.interactor.targetCurrency = self.exchangeRatesData.currencies[index];
            break;
    }
}

- (void)reloadView {
    [self reloadViewWithUpdateRates:YES];
}

- (void)reloadViewWithUpdateRates:(BOOL)updateRates {
    [self updateViewWithData:self.exchangeRatesData updateRates:updateRates];
}

- (void)updateExchangeButton {
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchUser:^(User *user) {
        Currency *sourceCurrency = weakSelf.interactor.sourceCurrency;
        Currency *targetCurrency = weakSelf.interactor.targetCurrency;
        
        BOOL isEqualCurrencies = sourceCurrency.currencyType == targetCurrency.currencyType;

        BOOL isDeficiency = [weakSelf checkUserHasBalanceDeficiency:user currency:sourceCurrency];
        
        BOOL isEnabled = !isDeficiency && !isEqualCurrencies;
        
        [weakSelf.view setExchangeButtonEnabled:isEnabled];
    }];
}

- (BOOL)checkUserHasBalanceDeficiency:(User *)user currency:(Currency *)currency {
    Wallet *wallet = [user walletWithCurrencyType:currency.currencyType];
    return self.expenseInput.floatValue > wallet.amount.floatValue;
}

- (void)dismissModule {
    [self.router dismissModule];
}

@end
