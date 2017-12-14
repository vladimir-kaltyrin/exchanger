#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Wallet : NSObject
@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, strong, readonly) Currency *currency;

- (instancetype)init __attribute__((unavailable("init not available")));

- (instancetype)initWithCurrency:(Currency *)currency
                          amount:(NSNumber *)amount;

- (CurrencyType)currencyType;

@end
