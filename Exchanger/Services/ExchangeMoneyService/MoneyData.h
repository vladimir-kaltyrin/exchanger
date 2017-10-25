#import <Foundation/Foundation.h>
#import "Currency.h"

@interface MoneyData : NSObject
@property (nonatomic, assign) CurrencyType currencyType;
@property (nonatomic, strong) NSNumber *amount;
@end
