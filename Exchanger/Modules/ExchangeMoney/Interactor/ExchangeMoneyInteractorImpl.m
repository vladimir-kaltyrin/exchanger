#import "ExchangeMoneyInteractorImpl.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "SafeBlocks.h"
#import "User.h"

@interface ExchangeMoneyInteractorImpl()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) id<UserService> userService;
@property (nonatomic, strong) id<ExchangeRatesService> exchangeRatesService;
@property (nonatomic, strong) id<IExchangeMoneyService> exchangeMoneyService;
@property (nonatomic, strong) id<ExchangeRatesUpdater> exchangeRatesUpdater;
@end

@implementation ExchangeMoneyInteractorImpl
@synthesize sourceCurrency;
@synthesize targetCurrency;

// MARK: - Init

- (instancetype)initWithUserService:(id<UserService>)userService
               exchangeRatesService:(id<ExchangeRatesService>)exchangeRatesService
               exchangeMoneyService:(id<IExchangeMoneyService>)exchangeMoneyService
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

- (void)exchange:(void (^)(MoneyData *))onExchange {
    
    MoneyData *moneyData = [self.user moneyDataWithCurrencyType:self.sourceCurrency.currencyType];
    
    [self.exchangeMoneyService exchangeMoney:moneyData.amount
                              sourceCurrency:self.sourceCurrency
                              targetCurrency:self.targetCurrency
                                    onResult:onExchange];
}

- (void)startFetching {
    [self.exchangeRatesUpdater start];
}

- (void)setOnUpdate:(void(^)(ExchangeRatesData *))onUpdate; {
    [self.exchangeRatesUpdater setOnUpdate:^(ExchangeRatesData * data) {
        block(onUpdate, data);
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
    self.sourceCurrency = [self findCurrencyWithType:CurrencyTypeUSD inData:data];
    self.targetCurrency = [self findCurrencyWithType:CurrencyTypeEUR inData:data];
    block(onReset);
}

// MARK: - Private

- (Currency *)findCurrencyWithType:(CurrencyType)currencyType inData:(ExchangeRatesData *)data {
    NSInteger indexOfCurrency = [data.currencies indexOfObjectPassingTest:^BOOL(Currency * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return obj.currencyType == currencyType;
    }];
    return [data.currencies objectAtIndex:indexOfCurrency];
}

@end
