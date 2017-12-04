#import <Foundation/Foundation.h>

#import "BalanceFormatter.h"

@protocol FormatterFactory <NSObject>
- (id<BalanceFormatter>)exchangeCurrencyInputFormatter;
- (id<BalanceFormatter>)currentBalanceFormatter;

@end
