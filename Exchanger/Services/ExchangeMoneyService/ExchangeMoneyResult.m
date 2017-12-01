#import "ExchangeMoneyResult.h"

@interface ExchangeMoneyResult()
@property (nonatomic, strong) Wallet *sourceWallet;
@property (nonatomic, strong) Wallet *targetWallet;
@end

@implementation ExchangeMoneyResult

- (instancetype)initWithSourceWallet:(Wallet *)sourceWallet
                        targetWallet:(Wallet *)targetWallet
{
    self = [super init];
    if (self) {
        self.sourceWallet = sourceWallet;
        self.targetWallet = targetWallet;
    }
    return self;
}

@end
