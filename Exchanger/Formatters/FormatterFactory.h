#import <Foundation/Foundation.h>

#import "BalanceFormatter.h"
#import "CurrencyFormatter.h"
#import "NumbersFormatter.h"

@protocol FormatterFactory <NSObject>
- (id<BalanceFormatter>)exchangeCurrencyInputFormatter;
- (id<BalanceFormatter>)currentBalanceFormatter;
- (id<CurrencyFormatter>)currencyFormatter;
- (id<NumbersFormatter>)numbersFormatter;

@end
