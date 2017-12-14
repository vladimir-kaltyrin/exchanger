#import "User.h"

@interface User()
@property (nonatomic, strong) NSMutableArray<Wallet *> *wallets;
@end

@implementation User

// MARK: - Init

- (instancetype)initWithWallets:(NSArray<Wallet *> *)wallets {
    if (self = [super init]) {
        self.wallets = [wallets mutableCopy];
    }
    return self;
}

// MARK: - User

- (void)setWallet:(Wallet *)wallet withCurrencyType:(CurrencyType)currencyType {
    NSInteger index = [self.wallets indexOfObjectPassingTest:^BOOL(Wallet * _Nonnull wallet, NSUInteger idx, BOOL * _Nonnull stop) {
        return wallet.currency.currencyType == currencyType;
    }];
    
    if (index == NSNotFound) {
        return;
    }
    
    [self.wallets replaceObjectAtIndex:index withObject:wallet];
}

- (Wallet *)walletWithCurrencyType:(CurrencyType)currencyType {
    NSInteger index = [self.wallets indexOfObjectPassingTest:^BOOL(Wallet * _Nonnull wallet, NSUInteger idx, BOOL * _Nonnull stop) {
        return wallet.currency.currencyType == currencyType;
    }];
    
    if (index != NSNotFound) {
        return [self.wallets objectAtIndex:index];
    }
    
    return nil;
}

@end
