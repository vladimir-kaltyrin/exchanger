#import "ExchangeMoneyPresenter.h"
#import "ExchangeRatesData.h"
#import "ExchangeMoneyViewData.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "GalleryPreviewPageData.h"
#import "GalleryPreviewData.h"
#import "KeyboardObserver.h"
#import "SafeBlocks.h"

typedef NS_ENUM(NSInteger, CurrencyExchangeType) {
    CurrencyExchangeSourceType,
    CurrencyExchangeTargetType
};

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
    
    [self.view setOnResetTap:^{
        executeIfNotNil(weakSelf.onFinish);
    }];
    
    [self.interactor setOnUpdate:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf updateViewWithData:data];
    }];
    
    [self.view startActivity];
    [self.interactor fetchRates:^(ExchangeRatesData *data) {
        [weakSelf.view stopActivity];
        [weakSelf.interactor resetCurrenciesWithData:data onReset:^{
            [weakSelf updateViewWithData:data];
            [weakSelf.interactor startFetching];
        }];
    } onError:^(NSError *error) {
        
    }];
}

- (void)updateViewWithData:(ExchangeRatesData *)data {
    [self updateExchangeRates:data onUpdate:nil];
    [self updateNavigationTitleRate:nil];
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

        GalleryPreviewData *sourceData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeSourceType
                                                                                  user:user
                                                                            currencies:ratesData.currencies];
        
        GalleryPreviewData *targetData = [weakSelf previewDataWithCurrencyExchangeType:CurrencyExchangeTargetType
                                                                                  user:user
                                                                            currencies:ratesData.currencies];
        
        ExchangeMoneyViewData *viewData = [[ExchangeMoneyViewData alloc] initWithSourceData:sourceData
                                                                                 targetData:targetData];
        
        [weakSelf.view setViewData:viewData];
        
        executeIfNotNil(onUpdate);
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
        switch (currencyExchangeType) {
            case CurrencyExchangeSourceType:
                rate = @"";
                break;
            case CurrencyExchangeTargetType:
                rate = currency.rate.stringValue;
                break;
        }
        
        GalleryPreviewPageData *pageData = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:currencyTitle
                                                                                  currencyAmount:@""
                                                                                       remainder:remainder
                                                                                            rate:rate];
        [pages addObject:pageData];
    }
    
    return [[GalleryPreviewData alloc] initWithPages:pages onTap:^{
        NSLog(@"onTap");
    }];
}

- (void)showTitle {
    [self.interactor exchange:^(MoneyData *moneyData) {
        
    }];
}

- (NSString *)balanceWithUser:(User *)user currencyType:(CurrencyType)currencyType {
    MoneyData *moneyData = [user moneyDataWithCurrencyType:currencyType];
    return [NSString stringWithFormat:@"You have %@", [moneyData.amount stringValue]];
}

@end
