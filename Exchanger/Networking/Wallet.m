#import "Wallet.h"

@interface Wallet()
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) Currency *currency;
@end

@implementation Wallet

- (instancetype)initWithCurrency:(Currency *)currency
                          amount:(NSNumber *)amount {
    self = [super init];
    if (self) {
        self.currency = currency;
        self.amount = amount;
    }
    return self;
}

@end
