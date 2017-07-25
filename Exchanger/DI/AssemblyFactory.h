#import <Foundation/Foundation.h>
#import "ExchangeMoneyAssembly.h"

@protocol AssemblyFactory <NSObject>
- (id<ExchangeMoneyAssembly>)exchangeMoneyAssembly;
@end
