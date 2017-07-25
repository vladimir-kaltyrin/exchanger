#import <UIKit/UIKit.h>

@class ExchangeMoneyCurrencyViewData;

@interface ExchangeMoneyCurrencyViewController : UIViewController

- (instancetype)initWithViewData:(ExchangeMoneyCurrencyViewData *)viewData
                           index:(NSInteger)pageIndex;

- (NSInteger)pageIndex;

@end
