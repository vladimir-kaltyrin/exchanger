#import "ConvenientObjC.h"
#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyViewData.h"
#import "CurrencyExchangeType.h"
#import "CarouselPageData.h"
#import "CarouselData.h"
#import "KeyboardObserver.h"
#import "FormatterFactoryImpl.h"
#import "ExchangeMoneyViewDataBuilder.h"
#import "Wallet.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) ExchangeRatesData *exchangeRatesData;
@property (nonatomic, assign) CurrencyExchangeType activeExchangeType;
@property (nonatomic, strong) FormatterResultData *expenseInput;
@property (nonatomic, strong) FormatterResultData *incomeInput;
@property (nonatomic, strong) id<ExchangeMoneyInteractor> interactor;
@property (nonatomic, strong) id<ExchangeMoneyRouter> router;
@property (nonatomic, strong) id<KeyboardObserver> keyboardObserver;
@property (nonatomic, strong) id<NumbersFormatter> numbersFormatter;
@property (nonatomic, strong) id<BalanceFormatter> exchangeCurrencyInputFormatter;
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
        
        self.numbersFormatter = [[FormatterFactoryImpl instance] numbersFormatter];
        self.exchangeCurrencyInputFormatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
    }
    
    return self;
}

- (void)setView:(id<ExchangeMoneyViewInput>)view {
    _view = view;
    
    [self setUpView];
}

// MARK: - Private

- (void)setUpView {

    self.activeExchangeType = CurrencyExchangeSourceType;
    self.incomeInput = [FormatterResultData formatterDataWithString:@(0).stringValue];
    self.expenseInput = [FormatterResultData formatterDataWithString:@(0).stringValue];
    
    __weak typeof(self) welf = self;
    [self.keyboardObserver setOnKeyboardData:^(KeyboardData *keyboardData) {
        [welf.view updateKeyboardData:keyboardData];
    }];
    
    [self.view setExchangeButtonEnabled:YES];
    
    [self.view setOnViewDidLoad:^{
        [welf.view startActivity];
        [welf.interactor startFetching];
    }];
    
    [self.view setOnViewWillAppear:^{
        [welf.view focusOnStart];
        [welf.view setActiveCurrencyExchangeType:welf.activeExchangeType];
    }];
    
    [self.view setOnExchangeTypeChange:^(CurrencyExchangeType newExchangeType) {
        welf.activeExchangeType = newExchangeType;
    }];
    
    [self.view setOnExchangeTap:^{
        [welf.interactor exchangeCurrency:welf.expenseInput.number
                               onExchange:^{
                                   [welf fetchRatesWithRepeat:NO
                                                     onUpdate:nil
                                                      onError:nil];
                                   
                               } onError:nil];
    }];
    
    [self.view setOnCancelTap:^{
        safeBlock(welf.onFinish);
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [welf.view stopActivity];
        [welf updateViewWithData:data];
    }];
    
    [self fetchRatesWithRepeat:YES
                      onUpdate:nil
                       onError:nil];
    
    [self.view setOnPageChange:^(CurrencyExchangeType exchangeType, NSInteger current) {
        [welf update:exchangeType withIndex:current];
        [welf configureInputsWithText:[welf currentInput].string
                             exchangeType:[welf activeExchangeType]
                             currencyType:[welf currentCurrency]];
    }];
}

- (void)updateViewWithData:(ExchangeRatesData *)data {
    [self updateExchangeButton];
    [self updateNavigationTitleRate:nil];
    [self updateExchangeRates:data onUpdate:nil];
}

- (void)updateNavigationTitleRate:(void(^)())onUpdate {
    __weak typeof(self) welf = self;
    [self.interactor convertedCurrency:^(Currency *convertedCurrency) {
        Currency *sourceCurrency = [welf.interactor sourceCurrency];

        [welf.view setExchangeSourceCurrency:sourceCurrency targetCurrency:convertedCurrency];
        safeBlock(onUpdate);
    }];
}

- (void)updateExchangeRates:(ExchangeRatesData *)ratesData onUpdate:(void(^)())onUpdate {
    
    __weak typeof(self) welf = self;
    [self.interactor fetchUser:^(User *user) {
        [welf updateViewWithUser:user ratesData:ratesData onUpdate:onUpdate];
    }];
}

- (void)updateViewWithUser:(User *)user ratesData:(ExchangeRatesData *)ratesData onUpdate:(void(^)())onUpdate {

    Wallet *inputWallet;
    Currency *targetCurrency;
    
    switch (self.activeExchangeType) {
        case CurrencyExchangeSourceType:
        {
            inputWallet = [[Wallet alloc] initWithCurrency:self.interactor.sourceCurrency
                                                    amount:self.expenseInput.number];
            targetCurrency = self.interactor.targetCurrency;
            
        }
            break;
        case CurrencyExchangeTargetType:
        {
            inputWallet = [[Wallet alloc] initWithCurrency:self.interactor.targetCurrency
                                                    amount:self.expenseInput.number];
            targetCurrency = self.interactor.sourceCurrency;
        }
            break;
    };
    
    __weak typeof(self) welf = self;
    [self.interactor convertedCurrencyWithSourceCurrency:self.interactor.targetCurrency
                                          targetCurrency:self.interactor.sourceCurrency
                                               onConvert:^(Currency *invertedRateCurrency)
    {
        BOOL isDeficiency = [welf checkUserHasBalanceDeficiency:user];
        
        let builder = [welf builderWithUser:user
                                 currencies:ratesData.currencies
                               invertedRate:invertedRateCurrency.rate
                               isDeficiency:isDeficiency];
        
        let viewData = [builder build];
        
        [welf.view setViewData:viewData];
        
        safeBlock(onUpdate);
    }];
}

- (ExchangeMoneyViewDataBuilder *)builderWithUser:(User *)user
                                       currencies:(NSArray *)currencies
                                     invertedRate:(NSNumber *)invertedRate
                                     isDeficiency:(BOOL)isDeficiency
{
    __weak typeof(self) welf = self;
    OnInputChange onInputChange = ^(NSString *text, CurrencyExchangeType exchangeType, CurrencyType currencyType) {
        [welf configureInputsWithText:text exchangeType:exchangeType currencyType:currencyType];
    };
    
    return [[ExchangeMoneyViewDataBuilder alloc] initWithUser:user
                                                   currencies:currencies
                                                  incomeInput:self.incomeInput
                                                 expenseInput:self.expenseInput
                                               sourceCurrency:self.interactor.sourceCurrency
                                               targetCurrency:self.interactor.targetCurrency
                                                 invertedRate:invertedRate
                                                 isDeficiency:isDeficiency
                                                onInputChange:onInputChange];
}

- (void)configureInputsWithText:(NSString *)text
                   exchangeType:(CurrencyExchangeType)exchangeType
                   currencyType:(CurrencyType)currencyType
{
    NSString *inputText;
    if ([self isInputValid:text]) {
        inputText = text;
    } else {
        inputText = [self currentInput].string;
    }
    
    NumbersFormatterData *numbersData = [self.numbersFormatter format:inputText];
    
    Wallet *inputWallet;
    Currency *targetCurrency;
    
    switch (self.activeExchangeType) {
        case CurrencyExchangeSourceType:
        {
            inputWallet = [[Wallet alloc] initWithCurrency:self.interactor.sourceCurrency
                                                    amount:numbersData.number];
            targetCurrency = self.interactor.targetCurrency;
            
        }
            break;
        case CurrencyExchangeTargetType:
        {
            inputWallet = [[Wallet alloc] initWithCurrency:self.interactor.targetCurrency
                                                    amount:numbersData.number];
            targetCurrency = self.interactor.sourceCurrency;
        }
            break;
    };
    
    __weak typeof(self) welf = self;
    [self.interactor exchangeWallet:inputWallet
                     targetCurrency:targetCurrency
                           onResult:^(Wallet *wallet)
    {
        switch (exchangeType) {
            case CurrencyExchangeSourceType:
            {
                if (welf.activeExchangeType != CurrencyExchangeSourceType) {
                    break;
                }
                if (welf.interactor.sourceCurrency.currencyType == currencyType) {
                    welf.expenseInput = [FormatterResultData formatterDataWithString:numbersData.string
                                                                                sign:BalanceFormatterSignMinus];
                    welf.incomeInput = [FormatterResultData formatterDataWithNumber:wallet.amount
                                                                               sign:BalanceFormatterSignPlus];
                    [welf reloadView];
                }
            }
                break;
            case CurrencyExchangeTargetType:
            {
                if (welf.activeExchangeType != CurrencyExchangeTargetType) {
                    break;
                }
                if (welf.interactor.targetCurrency.currencyType == currencyType) {
                    welf.expenseInput = [FormatterResultData formatterDataWithNumber:wallet.amount
                                                                                sign:BalanceFormatterSignMinus];
                    welf.incomeInput = [FormatterResultData formatterDataWithString:numbersData.string
                                                                               sign:BalanceFormatterSignPlus];
                    [welf reloadView];
                }
            }
                break;
        }
    }];
}

- (void)fetchRatesWithRepeat:(BOOL)repeat onUpdate:(void(^)())onUpdate onError:(void (^)(NSError *))onError {
    [self.view startActivity];
    
    __weak typeof(self) welf = self;
    [self.interactor fetchRates:^(ExchangeRatesData *data) {
        welf.exchangeRatesData = data;
        [welf.view stopActivity];
        [welf.interactor resetCurrenciesWithData:data onReset:^{
            [welf reloadView];
            if (repeat) {
                [welf.interactor startFetching];
            }
            safeBlock(onUpdate)
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
    [self updateViewWithData:self.exchangeRatesData];
}

- (void)updateExchangeButton {
    __weak typeof(self) welf = self;
    [self.interactor fetchUser:^(User *user) {
        let sourceCurrency = welf.interactor.sourceCurrency;
        let targetCurrency = welf.interactor.targetCurrency;
        
        let isEqualCurrencies = sourceCurrency.currencyType == targetCurrency.currencyType;
        let isDeficiency = [welf checkUserHasBalanceDeficiency:user];
        let isEnabled = !isDeficiency && !isEqualCurrencies;
        
        [welf.view setExchangeButtonEnabled:isEnabled];
    }];
}

- (BOOL)checkUserHasBalanceDeficiency:(User *)user {
    let wallet = [user walletWithCurrencyType:self.interactor.sourceCurrency.currencyType];
    return fabs(self.expenseInput.floatValue) > fabs(wallet.amount.floatValue);
}

- (FormatterResultData *)currentInput {
    switch (self.activeExchangeType) {
        case CurrencyExchangeSourceType:
            return self.expenseInput;
            break;
        case CurrencyExchangeTargetType:
            return self.incomeInput;
            break;
    }
}

- (CurrencyType)currentCurrency {
    switch (self.activeExchangeType) {
        case CurrencyExchangeSourceType:
            return self.interactor.sourceCurrency.currencyType;
            break;
        case CurrencyExchangeTargetType:
            return self.interactor.targetCurrency.currencyType;
            break;
    }
}

- (BOOL)isInputValid:(NSString *)input {
    return input.length <= 9;
}

- (void)dismissModule {
    [self.router dismissModule];
}

@end
