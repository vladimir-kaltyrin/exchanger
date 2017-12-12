#import "ObservableTextField.h"
#import "SafeBlocks.h"

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
    
    NSString *oldValue = self.text;
    
    if (self.formatter) {
        FormatterResultData *data = self.formatter(text);
        
        _text = data.string;
        
        [self setAttributedText:data.formattedString];
    } else {
        
        _text = text;
        
        self.textField.text = self.text;
    }
    
    if (![oldValue isEqualToString:text] && (oldValue != nil)) {
        block(self.onTextChange, self.text);
    }
}

// MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *resultString = self.text == nil ? @"" : self.text;
    if ([string isEqualToString:@""]) {
        if (resultString.length > 0) {
            resultString = [resultString substringToIndex:resultString.length - 1];
        }
    }  else {
        resultString = [NSString stringWithFormat:@"%@%@", self.text, string];
    }
    
    [self setText:resultString];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
