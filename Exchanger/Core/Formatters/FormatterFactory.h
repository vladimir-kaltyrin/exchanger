#import <Foundation/Foundation.h>

#import "BalanceFormatter.h"
#import "CurrencyFormatter.h"
#import "NumberFilterFormatter.h"
#import "RoundingFormatter.h"

@protocol FormatterFactory <NSObject>
- (id<BalanceFormatter>)exchangeCurrencyInputFormatter;
- (id<BalanceFormatter>)currentBalanceFormatter;
- (id<CurrencyFormatter>)currencyFormatter;
- (id<NumberFilterFormatter>)numberFilterFormatter;
- (id<RoundingFormatter>)roundingFormatter;

@end
