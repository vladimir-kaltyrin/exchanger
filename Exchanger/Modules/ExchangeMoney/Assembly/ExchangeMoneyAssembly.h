#import <Foundation/Foundation.h>
#import "AssembledViewController.h"

@class User;

@protocol ExchangeMoneyAssembly <NSObject>
- (AssembledViewController *)module;
@end
