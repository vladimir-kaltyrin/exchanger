#import <Foundation/Foundation.h>
#import "CurrencyType.h"

@interface Currency : NSObject
@property (nonatomic, assign) CurrencyType currencyType;
@property (nonatomic, strong) NSNumber *rate;
@end
