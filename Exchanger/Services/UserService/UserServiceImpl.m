#import "UserServiceImpl.h"
#import "User.h"
#import "Wallet.h"

@interface UserServiceImpl()
@property (nonatomic, strong) User *user;
@end

@implementation UserServiceImpl

// MARK: - Init

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

// MARK: - Private

- (void)setUp {
    Wallet *usdWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeUSD]
                                                  amount:@100];
    
    Wallet *eurWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeEUR]
                                                  amount:@200];
    
    Wallet *gbpWallet = [[Wallet alloc] initWithCurrency:[Currency currencyWithType:CurrencyTypeGBP]
                                                  amount:@300];
    
    User *user = [[User alloc] initWithWallets:@[usdWallet, eurWallet, gbpWallet]];
    
    self.user = user;
}

// MARK: - UserService

- (void)currentUser:(void (^)(User *))onCurrenUser {
    // There are hardcoded values, but it's supposed that data is fetched from service in the real app.
    onCurrenUser(self.user);
}

- (void)updateUser:(User *)user onUpdate:(void (^)())onUpdate {
    self.user = user;
    onUpdate();
}

@end
