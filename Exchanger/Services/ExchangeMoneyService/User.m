#import "User.h"

@interface User()
@property (nonatomic, strong) NSArray<MoneyData *> *wallet;
@end

@implementation User

// MARK: - Init

- (instancetype)initWithWallet:(NSArray<MoneyData *> *)wallet {
    if (self = [super init]) {
        self.wallet = wallet;
    }
    return self;
}

// MARK: - User

- (MoneyData *)moneyDataWithCurrencyType:(CurrencyType)currencyType {
    NSInteger index = [self.wallet indexOfObjectPassingTest:^BOOL(MoneyData * _Nonnull data, NSUInteger idx, BOOL * _Nonnull stop) {
        return data.currencyType == currencyType;
    }];
    
    if (index != NSNotFound) {
        return [self.wallet objectAtIndex:index];
    }
    
    return nil;
}

@end
