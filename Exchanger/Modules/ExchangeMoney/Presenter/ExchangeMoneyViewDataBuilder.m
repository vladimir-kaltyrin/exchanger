#import "ExchangeMoneyViewDataBuilder.h"
#import "User.h"
#import "GalleryPreviewData.h"

@interface ExchangeMoneyViewDataBuilder()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@property (nonatomic, strong) NSNumber *currentInput;
@property (nonatomic, strong) NSAttributedString *formattedInput;
@property (nonatomic, assign) CurrencyType sourceCurrencyType;
@property (nonatomic, assign) CurrencyType targetCurrencyType;

@end

@implementation ExchangeMoneyViewDataBuilder

// MARK: - Init

- (instancetype)initWithUser:(User *)user
                  currencies:(NSArray<Currency *> *)currencies
                currentInput:(NSNumber *)currentInput
              formattedInput:(NSAttributedString *)formattedInput
          sourceCurrencyType:(CurrencyType)sourceCurrencyType
          targetCurrencyType:(CurrencyType)targetCurrencyType
{
    self = [super init];
    if (self) {
        self.user = user;
        self.currencies = currencies;
        self.currentInput = currentInput;
        self.formattedInput = formattedInput;
        self.sourceCurrencyType = sourceCurrencyType;
        self.targetCurrencyType = targetCurrencyType;
    }
    return self;
}

// MARK: - Public

- (ExchangeMoneyViewData *)build {
    
    
    
    return nil;
}

// MARK: - Private



- (BOOL)checkUserHasBalanceDeficiency:(User *)user currency:(Currency *)currency {
    Wallet *wallet = [user walletWithCurrencyType:currency.currencyType];
    return self.currentInput.floatValue > wallet.amount.floatValue;
}

@end
