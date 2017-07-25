#import <Foundation/Foundation.h>
#import "AssembledViewController.h"

@protocol ExchangeMoneyAssembly <NSObject>
- (AssembledViewController *)module;
@end
