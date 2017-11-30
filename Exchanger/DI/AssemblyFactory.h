#import <Foundation/Foundation.h>
#import "ExchangeMoneyAssembly.h"
#import "IntroAssembly.h"

@protocol AssemblyFactory <NSObject>
- (id<ExchangeMoneyAssembly>)exchangeMoneyAssembly;
- (id<IntroAssembly>)introAssembly;
@end
