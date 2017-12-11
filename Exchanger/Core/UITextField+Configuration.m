#import "UITextField+Configuration.h"

@implementation UITextField (Configuration)

- (void)setConfiguration:(TextFieldConfiguration *)configuration {
    self.font = configuration.font;
    self.textColor = configuration.textColor;
    self.textAlignment = configuration.textAlignment;
    self.keyboardType = configuration.keyboardType;
}

@end
