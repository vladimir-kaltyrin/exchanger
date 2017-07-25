#import <Foundation/Foundation.h>
#import "Currency.h"

@interface MoneyData : NSObject
@property (nonatomic, strong) Currency *currency;
@property (nonatomic, strong) NSNumber *amount;
@end
