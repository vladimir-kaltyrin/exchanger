#import <Foundation/Foundation.h>
#import "AssembledViewController.h"
#import "ExchangeMoneyModule.h"

@class User;

@protocol ExchangeMoneyAssembly <NSObject>
- (AssembledViewController *)module;
@end
