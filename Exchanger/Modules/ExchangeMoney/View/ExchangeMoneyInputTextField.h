#import <UIKit/UIKit.h>

@interface ExchangeMoneyInputTextField : UIView

- (void)setOnInputChange:(void (^)(NSNumber *))onInputChange;

- (void)setText:(NSString *)text;

@end
