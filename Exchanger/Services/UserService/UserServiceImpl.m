#import "UserServiceImpl.h"
#import "User.h"
#import "Wallet.h"
#import "ExchangeMoneyData.h"
#import "UserDataStorage.h"

@interface UserServiceImpl()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) id<UserDataStorage> userDataStorage;
@end

@implementation UserServiceImpl

// MARK: - Init

- (instancetype)initWithUserDataStorage:(id<UserDataStorage>)userDataStorage {
    if (self = [super init]) {
        self.userDataStorage = userDataStorage;
        
        [self setUp];
    }
    return self;
}

// MARK: - Private

- (void)setUp {
    Wallet *usdWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeUSD]
                                                  amount:@100];
    
    Wallet *eurWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeEUR]
                                                  amount:@100];
    
    Wallet *gbpWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeGBP]
                                                  amount:@100];
    
    User *user = [[User alloc] initWithWallets:@[usdWallet, eurWallet, gbpWallet]];
    
    self.user = user;
}

// MARK: - UserService

- (void)currentUser:(void (^)(User *))onCurrenUser {
    // There are hardcoded values, but it's supposed that data is fetched from service in the real app.
    onCurrenUser(self.user);
}

- (void)updateUserWithExchangeMoneyData:(ExchangeMoneyData *)data {
    [self.user setWallet:data.sourceWallet withCurrencyType:data.sourceWallet.currencyType];
    [self.user setWallet:data.targetWallet withCurrencyType:data.targetWallet.currencyType];
}

@end
