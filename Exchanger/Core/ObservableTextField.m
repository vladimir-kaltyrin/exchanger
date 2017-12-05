#import "ObservableTextField.h"

@interface ObservableTextField() <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ObservableTextField

// MARK: - Init

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.delegate = self;
        
        [self addSubview:self.textField];
    }
    return self;
}

// MARK: - FirstResponder

- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (BOOL)isFirstResponder {
    return [self.textField isFirstResponder];
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = self.bounds;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.textField sizeThatFits:size];
}

// MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.onTextChange != nil) {
        return self.onTextChange([NSString stringWithFormat:@"%@%@", textField.text, string]);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
