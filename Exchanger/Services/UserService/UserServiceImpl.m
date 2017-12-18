#import "UserServiceImpl.h"
#import "User.h"
#import "Wallet.h"
#import "ExchangeMoneyData.h"
#import "UserDataStorage.h"
#import "ConvenientObjC.h"

@interface UserServiceImpl()
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
    __weak typeof(self) welf = self;
    [self.userDataStorage user:^(User *user) {
        if (user == nil) {
            let usdWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeUSD]
                                                          amount:@100];
            
            let eurWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeEUR]
                                                          amount:@100];
            
            let gbpWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeGBP]
                                                          amount:@100];
            
            User *user = [[User alloc] initWithWallets:@[usdWallet, eurWallet, gbpWallet]];
            
            [welf.userDataStorage saveUser:user];
        }
    }];
}

// MARK: - UserService

- (void)currentUser:(void (^)(User *))onCurrenUser {
    [self.userDataStorage user:onCurrenUser];
}

- (void)updateUserWithExchangeMoneyData:(ExchangeMoneyData *)data {
    
    __weak typeof(self) welf = self;
    [self currentUser:^(User *user) {
        
        [user setWallet:data.sourceWallet withCurrencyType:data.sourceWallet.currencyType];
        [user setWallet:data.targetWallet withCurrencyType:data.targetWallet.currencyType];
        
        [welf.userDataStorage saveUser:user];
    }];
}

@end
