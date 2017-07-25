#import "ExchangeMoneyInteractorImpl.h"
#import "ExchangeRatesUpdater.h"
#import "ExchangeMoneyService.h"
#import "User.h"

@interface ExchangeMoneyInteractorImpl()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Currency *currency;
@property (nonatomic, strong) id<IExchangeMoneyService> exchangeMoneyService;
@property (nonatomic, strong) id<ExchangeRatesUpdater> exchangeRatesUpdater;
@end

@implementation ExchangeMoneyInteractorImpl

// MARK: - Init

- (instancetype)initWithUser:(User *)user
        exchangeMoneyService:(id<IExchangeMoneyService>)exchangeMoneyService
        exchangeRatesUpdater:(id<ExchangeRatesUpdater>)exchangeRatesUpdater;
{
    self = [super init];
    if (self) {
        self.user = user;
        self.exchangeMoneyService = exchangeMoneyService;
        self.exchangeRatesUpdater = exchangeRatesUpdater;
    }
    
    return self;
}

// MARK: - EchangeMoneyInteractor

- (void)exchange:(void (^)(MoneyData *))onExchange {
    [self.exchangeMoneyService exchange:self.user.moneyData
                             toCurrency:self.currency
                               onResult:onExchange];
}

- (void)startFetching {
    [self.exchangeRatesUpdater start];
}

- (void)setOnUpdate:(void (^)())onUpdate {
    [self.exchangeRatesUpdater setOnUpdate:^(ExchangeRatesData * data) {
        onUpdate();
    }];
}

@end
