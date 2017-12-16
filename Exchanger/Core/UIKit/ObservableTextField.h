#import <UIKit/UIKit.h>
#import "TextFieldConfiguration.h"
#import "FormatterData.h"

typedef void(^OnTextChange)(NSString *);
typedef void(^OnBeginEditing)();

@interface ObservableTextField : UIView
@property (nonatomic, strong) OnTextChange onTextChange;
@property (nonatomic, strong) OnBeginEditing onBeginEditing;

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (void)setConfiguration:(TextFieldConfiguration *)configuration;

- (void)setAttributedText:(NSAttributedString *)text;

- (void)setText:(NSString *)text;

@end
