#import "UserServiceImpl.h"
#import "User.h"

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
    MoneyData *usd = [[MoneyData alloc] init];
    usd.amount = @100;
    usd.currencyType = CurrencyTypeUSD;
    
    MoneyData *eur = [[MoneyData alloc] init];
    eur.amount = @101;
    eur.currencyType = CurrencyTypeEUR;
    
    MoneyData *gbp = [[MoneyData alloc] init];
    gbp.amount = @102;
    gbp.currencyType = CurrencyTypeGBP;
    
    User *user = [[User alloc] initWithWallet:@[usd, eur, gbp]];
    
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
