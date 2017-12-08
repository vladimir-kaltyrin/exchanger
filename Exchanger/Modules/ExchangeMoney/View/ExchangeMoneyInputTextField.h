#import <UIKit/UIKit.h>

@interface ExchangeMoneyInputTextField : UIView

- (void)setOnInputChange:(void (^)(NSString *))onInputChange;

- (void)setText:(NSString *)text;

@end
