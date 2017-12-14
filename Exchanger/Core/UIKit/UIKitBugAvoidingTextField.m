#import "UIKitBugAvoidingTextField.h"

// There are side effects in UIKit related to performing animation on becomeFirstResponder and resignFirstResponder.
// In case of quick switching between first responders this behaviour leads to animation defect when cursor jumps sometimes.

@interface UIKitBugAvoidingTextField()
@property (nonatomic, strong) UIColor *caretColor;
@end

@implementation UIKitBugAvoidingTextField

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self addTarget:self
                 action:@selector(didBeginEditing)
       forControlEvents:UIControlEventEditingDidBegin];
        
        [self addTarget:self
                 action:@selector(didEndEditing)
       forControlEvents:UIControlEventEditingDidEnd];
        
        [self updateTintColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setTintColor:(UIColor *)tintColor {
    self.caretColor = tintColor;
}

- (void)didBeginEditing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makeCursorVisible];
    });
}

- (void)didEndEditing {
    [self updateTintColor:[UIColor clearColor]];
}

- (void)makeCursorVisible {
    [self updateTintColor:self.caretColor];
}

- (void)updateTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
}

@end
