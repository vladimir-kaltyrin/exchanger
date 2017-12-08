#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyViewData.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"
#import "GalleryPreviewData.h"
#import "KeyboardObserver.h"
#import "FormatterFactoryImpl.h"
#import "SafeBlocks.h"
#import "Wallet.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) ExchangeRatesData *exchangeRatesData;
@property (nonatomic, strong) NSNumber *currentInput;
@property (nonatomic, strong) NSAttributedString *formattedInput;
@property (nonatomic, strong) id<ExchangeMoneyInteractor> interactor;
@property (nonatomic, strong) id<ExchangeMoneyRouter> router;
@property (nonatomic, strong) id<KeyboardObserver> keyboardObserver;
@property (nonatomic, strong) id<BalanceFormatter> exchangeCurrencyInputFormatter;
@property (nonatomic, strong) id<RoundingFormatter> roundingFormatter;
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
        
        self.exchangeCurrencyInputFormatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
        self.roundingFormatter = [[FormatterFactoryImpl instance] roundingFormatter];
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
    
    [self.view setExchangeButtonEnabled:YES];
    
    [self.view setOnViewDidLoad:^{
        [weakSelf.view startActivity];
        [weakSelf.interactor startFetching];
    }];
    
    [self.view setOnViewWillAppear:^{
        [weakSelf.view focusOnStart];
    }];
    
    [self.view setOnExchangeTap:^{
        [weakSelf.interactor exchangeCurrency:weakSelf.currentInput
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
        [weakSelf reloadViewWithUpdateRates:NO];
    }];
    
    [self.view setOnInputChange:^(NSString *inputChange) {
        weakSelf.currentInput = @(inputChange.floatValue);
        
        NSString *input;
        if (weakSelf.currentInput.floatValue > 0) {
            input = [NSString stringWithFormat:@"-%@", inputChange];
        } else {
            input = inputChange;
        }
        
        weakSelf.formattedInput = [weakSelf.exchangeCurrencyInputFormatter attributedFormatBalance:input];
        
        [weakSelf reloadView];
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
                                                        amount:self.currentInput];
        [weakSelf.interactor exchangeWallet:inputWallet
                             targetCurrency:weakSelf.interactor.targetCurrency
                                   onResult:^(Wallet *targetWallet, NSNumber *invertedRate)
        {
            GalleryPreviewData *sourceData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType
                                                                                      user:user
                                                                                currencies:ratesData.currencies
                                                                              targetWallet:targetWallet
                                                                              invertedRate:invertedRate];
            
            GalleryPreviewData *targetData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType
                                                                                      user:user
                                                                                currencies:ratesData.currencies
                                                                              targetWallet:targetWallet
                                                                              invertedRate:invertedRate];
            
            ExchangeMoneyViewData *viewData = [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                                                     targetData:targetData];
            
            [weakSelf.view setViewData:viewData];
            
            block(onUpdate);
        }];
    }];
}

- (GalleryPreviewData *)previewDataWithCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType
                                                       user:(User *)user
                                                 currencies:(NSArray<Currency *> *)currencies
                                               targetWallet:(Wallet *)targetWallet
                                               invertedRate:(NSNumber *)invertedRate
{
    NSMutableArray<GalleryPreviewPageData *> *pages = [NSMutableArray array];
    
    for (Currency *currency in currencies) {
        
        NSString *currencyTitle = currency.currencyCode;
        NSString *remainder = [self balanceWithUser:user currencyType:currency.currencyType];
        NSString *rate;
        NSAttributedString *currencyAmount;
        GalleryPreviewPageRemainderStyle remainderStyle = GalleryPreviewPageRemainderStyleNormal;
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
            {
                rate = @"";
                
                currencyAmount = self.formattedInput;
                
                if ([self checkUserHasBalanceDeficiency:user currency:currency]) {
                    remainderStyle = GalleryPreviewPageRemainderStyleDeficiency;
                } else {
                    remainderStyle = GalleryPreviewPageRemainderStyleNormal;
                }
            }
                break;
            case CurrencyExchangeTargetType:
            {
                NSNumber *targetAmount = targetWallet.amount;
                NSString *targetInput;
                if (targetAmount.floatValue > 0) {
                    targetInput = [NSString stringWithFormat:@"+%@", targetAmount];
                } else {
                    targetInput = targetAmount.stringValue;
                }
                
                currencyAmount = [self.exchangeCurrencyInputFormatter attributedFormatBalance:targetInput];
                
                rate = [NSString stringWithFormat:@"%@1 = %@%@",
                        currency.currencySign,
                        self.interactor.sourceCurrency.currencySign,
                        [self.roundingFormatter format:invertedRate]];
            }                break;
        }
        
        GalleryPreviewPageData *pageData = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:currencyTitle
                                                                                  currencyAmount:currencyAmount
                                                                                       remainder:remainder
                                                                                            rate:rate
                                                                                  remainderStyle:remainderStyle];
        [pages addObject:pageData];
    }
    
    NSInteger currentPage = [currencies indexOfObjectPassingTest:^BOOL(Currency * _Nonnull currency, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
                return currency.currencyType == self.interactor.sourceCurrency.currencyType;
                break;
            case CurrencyExchangeTargetType:
                return currency.currencyType == self.interactor.targetCurrency.currencyType;
                break;
        }
    }];
    
    if (currentPage == NSNotFound) {
        currentPage = 0;
    }
    
    GalleryPreviewData *viewData = [[GalleryPreviewData alloc] initWithPages:pages
                                                                 currentPage:currentPage
                                                                       onTap:nil];

    return viewData;
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    Wallet *wallet = [user walletWithCurrencyType:currencyType];
    Currency *currency = wallet.currency;
    return [NSString stringWithFormat:@"You have %@%@",
            currency.currencySign,
            [self.roundingFormatter format:wallet.amount]];
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
    return self.currentInput.floatValue > wallet.amount.floatValue;
}

- (void)dismissModule {
    [self.router dismissModule];
}

@end
