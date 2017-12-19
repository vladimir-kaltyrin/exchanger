#import "UserServiceImpl.h"
#import "User.h"
#import "Wallet.h"
#import "ExchangeMoneyData.h"
#import "UserDataStorage.h"
#import "ConvenientObjC.h"

typedef void(^OnSetup)();

@interface UserServiceImpl()
@property (nonatomic, strong) id<UserDataStorage> userDataStorage;
@property (nonatomic, strong) User *currentUser;
@end

@implementation UserServiceImpl

// MARK: - Init

- (instancetype)initWithUserDataStorage:(id<UserDataStorage>)userDataStorage {
    if (self = [super init]) {
        self.userDataStorage = userDataStorage;
    }
    return self;
}

// MARK: - Private

- (void)setUpWithCompletion:(OnSetup)onSetup {
    __weak typeof(self) welf = self;
    [self.userDataStorage user:^(User *user) {
        if (user == nil) {
            let usdWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeUSD]
                                                          amount:@100];
            
            let eurWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeEUR]
                                                          amount:@100];
            
            let gbpWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeGBP]
                                                          amount:@100];
            
            welf.currentUser = [[User alloc] initWithWallets:@[usdWallet, eurWallet, gbpWallet]];
            
            [welf.userDataStorage saveUser:welf.currentUser];
            
        } else {
            welf.currentUser = user;
        }
        
        safeBlock(onSetup);
    }];
}

// MARK: - UserService

- (void)currentUser:(void (^)(User *))onCurrenUser {
    if (self.currentUser == nil) {
        __weak typeof(self) welf = self;
        [self setUpWithCompletion:^{
            safeBlock(onCurrenUser, welf.currentUser);
        }];
    } else {
        safeBlock(onCurrenUser, self.currentUser);
    }
}

- (void)updateUserWithExchangeMoneyData:(ExchangeMoneyData *)data {
    [self.currentUser setWallet:data.sourceWallet withCurrencyType:data.sourceWallet.currencyType];
    [self.currentUser setWallet:data.targetWallet withCurrencyType:data.targetWallet.currencyType];
    [self.userDataStorage saveUser:self.currentUser];
}

@end
