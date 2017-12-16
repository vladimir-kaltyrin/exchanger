#import "ConvenientObjC.h"
#import "ExchangeMoneyInteractorImpl.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "User.h"

@interface ExchangeMoneyInteractorImpl()
@property (nonatomic, strong) id<UserService> userService;
@property (nonatomic, strong) id<ExchangeRatesService> exchangeRatesService;
@property (nonatomic, strong) id<ExchangeMoneyService> exchangeMoneyService;
@property (nonatomic, strong) id<ExchangeRatesUpdater> exchangeRatesUpdater;
@end

@implementation ExchangeMoneyInteractorImpl
@synthesize sourceCurrency;
@synthesize targetCurrency;

// MARK: - Init

- (instancetype)initWithUserService:(id<UserService>)userService
               exchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService
               exchangeMoneyService:(id<ExchangeMoneyService>)exchangeMoneyService
               exchangeRatesUpdater:(id<ExchangeRatesUpdater>)exchangeRatesUpdater
{
    self = [super init];
    if (self) {
        self.userService = userService;
        self.exchangeRatesService = exchangeRatesService;
        self.exchangeMoneyService = exchangeMoneyService;
        self.exchangeRatesUpdater = exchangeRatesUpdater;
    }
    
    return self;
}

// MARK: - EchangeMoneyInteractor

- (void)convertedCurrency:(void (^)(Currency *))onConvert {
    [self.exchangeMoneyService convertedCurrencyWithSourceCurrency:self.sourceCurrency
                                                    targetCurrency:self.targetCurrency
                                                         onConvert:^(Currency *currency)
    {
        onConvert(currency);
    }];
}

- (void)exchangeCurrency:(NSNumber *)currencyAmount
              onExchange:(void (^)())onExchange
                 onError:(void (^)())onError
{
    
    __weak typeof(self) welf = self;
    [self.userService currentUser:^(User *user) {
        let wallet = [user walletWithCurrencyType:welf.sourceCurrency.currencyType];
        
        if (currencyAmount.floatValue > wallet.amount.floatValue) {
            safeBlock(onError);
            return;
        }
        
        [welf.exchangeMoneyService exchangeWithUser:user
                                        moneyAmount:currencyAmount
                                     sourceCurrency:welf.sourceCurrency
                                     targetCurrency:welf.targetCurrency
                                           onResult:^(ExchangeMoneyData *result) {
                                               
                                               [welf update:user withExchangeMoneyResult:result];

                                               safeBlock(onExchange);
                                           }];
    }];
}

- (void)startFetching {
    [self.exchangeRatesUpdater start];
}

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate; {
    [self.exchangeRatesUpdater setOnUpdate:^(ExchangeRatesData * data) {
        safeBlock(onUpdate, data);
    }];
}

- (void)fetchUser:(void (^)(User *))onUser {
    [self.userService currentUser:onUser];
}

- (void)fetchRates:(void (^)(ExchangeRatesData *))onRates
           onError:(void (^)(NSError *))onError
{
    [self.exchangeRatesService fetchRates:onRates
                                  onError:onError];
}

- (void)resetCurrenciesWithData:(ExchangeRatesData *)data onReset:(void (^)())onReset {
    
    CurrencyType sourceCurrencyType;
    if (self.sourceCurrency == nil) {
        sourceCurrencyType = CurrencyTypeUSD;
    } else {
        sourceCurrencyType = self.sourceCurrency.currencyType;
    }
    self.sourceCurrency = [self findCurrencyWithType:sourceCurrencyType inData:data];
    
    CurrencyType targetCurrencyType;
    if (self.targetCurrency == nil) {
        targetCurrencyType = CurrencyTypeGBP;
    } else {
        targetCurrencyType = self.targetCurrency.currencyType;
    }
    self.targetCurrency = [self findCurrencyWithType:targetCurrencyType inData:data];

    safeBlock(onReset);
}

- (void)exchangeWallet:(Wallet *)wallet
        targetCurrency:(Currency *)currency
              onResult:(void(^)(Wallet *wallet))onResult
{
    [self.exchangeMoneyService exchangeWallet:wallet
                               targetCurrency:currency
                                     onResult:onResult];
}

- (void)convertedCurrencyWithSourceCurrency:(Currency *)sourceCurrency
                             targetCurrency:(Currency *)targetCurrency
                                  onConvert:(void(^)(Currency *))onConvert
{
    [self.exchangeMoneyService convertedCurrencyWithSourceCurrency:sourceCurrency
                                                    targetCurrency:targetCurrency
                                                         onConvert:onConvert];
}

// MARK: - Private

- (void)update:(User *)user withExchangeMoneyResult:(ExchangeMoneyData *)result {
    [user setWallet:result.sourceWallet withCurrencyType:result.sourceWallet.currencyType];
    [user setWallet:result.targetWallet withCurrencyType:result.targetWallet.currencyType];
}

- (Currency *)findCurrencyWithType:(CurrencyType)currencyType inData:(ExchangeRatesData *)data {
    return [data.currencies find:^BOOL(Currency *currency) {
        return currency.currencyType == currencyType;
    }];
}

@end
