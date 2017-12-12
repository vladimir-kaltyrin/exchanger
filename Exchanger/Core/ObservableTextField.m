#import "ObservableTextField.h"

@interface ObservableTextField() <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *text;
@end

@implementation ObservableTextField

// MARK: - Init

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.delegate = self;
        self.text = @"";
        
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

// MARK: - Public

- (void)setConfiguration:(TextFieldConfiguration *)configuration {
    self.textField.font = configuration.font;
    self.textField.textColor = configuration.textColor;
    self.textField.textAlignment = configuration.textAlignment;
    self.textField.keyboardType = configuration.keyboardType;
}

- (void)setAttributedText:(NSAttributedString *)text {
    self.textField.attributedText = text;
}

- (void)setText:(NSString *)text {
    if (self.formatter) {
        [self setAttributedText:self.formatter(text)];
    } else {
        self.textField.text = text;
    }
}

// MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.onTextChange == nil) {
        return YES;
    }
    
    NSString *resultString = self.text;
    if ([string isEqualToString:@""]) {
        if (resultString.length > 0) {
            resultString = [resultString substringToIndex:resultString.length - 1];
        }
    }  else {
        resultString = [NSString stringWithFormat:@"%@%@", self.text, string];
    }
    
    [self setText:resultString];
    
    return self.onTextChange(resultString);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
