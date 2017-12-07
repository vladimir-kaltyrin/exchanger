#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyViewData.h"
#import "CurrencyExchangeType.h"
#import "GalleryPreviewPageData.h"
#import "GalleryPreviewData.h"
#import "KeyboardObserver.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) ExchangeRatesData *exchangeRatesData;
@property (nonatomic, strong) NSNumber *currentInput;
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
    
    [self.view setExchangeButtonEnabled:YES];
    
    [self.view setOnViewDidLoad:^{
        [weakSelf.view startActivity];
        [weakSelf.interactor startFetching];
    }];
    
    [self.view setOnViewWillAppear:^{
        [weakSelf.view focusOnStart];
    }];
    
    [self.view setOnExchangeTap:^{
        [weakSelf.interactor exchange:^{
            [weakSelf fetchRatesWithRepeat:NO
                                  onUpdate:nil
                                   onError:nil];
        }];
    }];
    
    // TODO: fix retain-reference cycle
    [self.view setOnBackTap:^{
        block(self.onFinish);
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf updateViewWithData:data];
    }];
    
    [self fetchRatesWithRepeat:YES
                      onUpdate:nil
                       onError:nil];
    
    [self.view setOnPageChange:^(CurrencyExchangeType exchangeType, NSInteger current) {
        [weakSelf update:exchangeType withIndex:current];
        [weakSelf updateExchangeButton];
    }];
    
    [self.view setOnInputChange:^(NSNumber *inputChange) {
        weakSelf.currentInput = inputChange;
        [weakSelf reloadView];
    }];
}

- (void)updateViewWithData:(ExchangeRatesData *)data {
    [self updateExchangeButton];
    [self updateExchangeRates:data onUpdate:nil];
    [self updateNavigationTitleRate:nil];
}

- (void)updateNavigationTitleRate:(void(^)())onUpdate {
    __weak typeof(self) weakSelf = self;
    [self.interactor convertedCurrency:^(Currency *convertedCurrency) {
        NSString *sourceCurrencySign = [weakSelf.interactor sourceCurrency].currencySign;

        NSString *sourceCurrency = [NSString stringWithFormat:@"1%@", sourceCurrencySign];
        NSString *targetCurrency = convertedCurrency.rate.stringValue;
        [weakSelf.view setExchangeSourceCurrency:sourceCurrency targetCurrency:targetCurrency];
        block(onUpdate);
    }];
}

- (void)updateExchangeRates:(ExchangeRatesData *)ratesData onUpdate:(void(^)())onUpdate {
    
    __weak typeof(self) weakSelf = self;
    
    [self.interactor fetchUser:^(User *user) {

        GalleryPreviewData *sourceData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType
                                                                                  user:user
                                                                            currencies:ratesData.currencies];
        
        GalleryPreviewData *targetData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType
                                                                                  user:user
                                                                            currencies:ratesData.currencies];
        
        ExchangeMoneyViewData *viewData = [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                                                 targetData:targetData];
        
        [weakSelf.view setViewData:viewData];
        
        block(onUpdate);
    }];
}

- (GalleryPreviewData *)previewDataWithCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType
                                                       user:(User *)user
                                                 currencies:(NSArray<Currency *> *)currencies
{
    NSMutableArray<GalleryPreviewPageData *> *pages = [NSMutableArray array];
    
    for (Currency *currency in currencies) {
        
        NSString *currencyTitle = currency.currencyCode;
        NSString *remainder = [self balanceWithUser:user currencyType:currency.currencyType];
        NSString *rate;
        GalleryPreviewPageRemainderStyle remainderStyle = GalleryPreviewPageRemainderStyleNormal;
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
            {
                rate = @"";
                
                if ([self checkUserHasBalanceDeficiency:user currency:currency]) {
                    remainderStyle = GalleryPreviewPageRemainderStyleDeficiency;
                } else {
                    remainderStyle = GalleryPreviewPageRemainderStyleNormal;
                }
            }
                break;
            case CurrencyExchangeTargetType:
                rate = currency.rate.stringValue;
                break;
        }
        
        GalleryPreviewPageData *pageData = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:currencyTitle
                                                                                  currencyAmount:@""
                                                                                       remainder:remainder
                                                                                            rate:rate
                                                                                  remainderStyle:remainderStyle];
        [pages addObject:pageData];
    }
    
    return [[GalleryPreviewData alloc] initWithPages:pages onTap:^{
        NSLog(@"onTap");
    }];
}

- (void)showTitle {
    [self.interactor exchange:^(Wallet *wallet) {
        
    }];
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    Wallet *wallet = [user walletWithCurrencyType:currencyType];
    return [NSString stringWithFormat:@"You have %@", [wallet.amount stringValue]];
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
    [self updateViewWithData:self.exchangeRatesData];
}

- (void)updateExchangeButton {
    __weak typeof(self) weakSelf = self;
    [self.interactor fetchUser:^(User *user) {
        Currency *sourceCurrency = weakSelf.interactor.sourceCurrency;
        BOOL isDeficiency = [weakSelf checkUserHasBalanceDeficiency:user currency:sourceCurrency];
        [weakSelf.view setExchangeButtonEnabled:!isDeficiency];
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
