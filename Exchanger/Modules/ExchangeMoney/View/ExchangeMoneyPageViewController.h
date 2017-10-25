#import <UIKit/UIKit.h>
#import "ExchangeMoneyCurrencyViewData.h"
#import "CurrencyType.h"

@interface ExchangeMoneyPageViewController : UIViewController
@property (nonatomic, strong) NSArray<ExchangeMoneyCurrencyViewData *> *viewData;
@property (nonatomic, strong) void(^onPageShown)();

@end
