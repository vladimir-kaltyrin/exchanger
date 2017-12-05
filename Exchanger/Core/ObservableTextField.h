#import <UIKit/UIKit.h>
#import "TextFieldConfiguration.h"

@interface ObservableTextField : UIView
@property (nonatomic, strong) BOOL(^onTextChange)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (void)setConfiguration:(TextFieldConfiguration *)configuration;

- (void)setAttributedText:(NSAttributedString *)text;

@end
