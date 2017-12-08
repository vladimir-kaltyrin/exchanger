#import <Foundation/Foundation.h>

#import "BalanceFormatter.h"
#import "CurrencyFormatter.h"
#import "NumbersFormatter.h"
#import "RoundingFormatter.h"

@protocol FormatterFactory <NSObject>
- (id<BalanceFormatter>)exchangeCurrencyInputFormatter;
- (id<BalanceFormatter>)currentBalanceFormatter;
- (id<CurrencyFormatter>)currencyFormatter;
- (id<NumbersFormatter>)numbersFormatter;
- (id<RoundingFormatter>)roundingFormatter;

@end
