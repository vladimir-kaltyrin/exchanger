#import <UIKit/UIKit.h>
#import "TextFieldConfiguration.h"

typedef NSAttributedString *(^TextFieldAttributedStringFormatter)(NSString *text);

@interface ObservableTextField : UIView
@property (nonatomic, strong) BOOL(^onTextChange)(NSString *text);
@property (nonatomic, strong) TextFieldAttributedStringFormatter formatter;

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (void)setConfiguration:(TextFieldConfiguration *)configuration;

- (void)setText:(NSString *)text;

@end
