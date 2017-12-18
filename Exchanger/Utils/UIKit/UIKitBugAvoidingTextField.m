#import "UIKitBugAvoidingTextField.h"

@interface UIKitBugAvoidingTextField()
@property (nonatomic, strong) UIColor *caretColor;
@end

@implementation UIKitBugAvoidingTextField

// MARK: - Init

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

// MARK: - Public

- (void)setTintColor:(UIColor *)tintColor {
    self.caretColor = tintColor;
}

// MARK: - Private

- (void)makeCursorVisible {
    [self updateTintColor:self.caretColor];
}

- (void)updateTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
}

// MARK: - UITextField events

- (void)didBeginEditing {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makeCursorVisible];
    });
}

- (void)didEndEditing {
    [self updateTintColor:[UIColor clearColor]];
}

@end
