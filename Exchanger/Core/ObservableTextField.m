#import "ObservableTextField.h"
#import "SafeBlocks.h"

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
        
        [self.textField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
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
    self.textField.tintColor = configuration.tintColor;
    self.textField.textAlignment = configuration.textAlignment;
    self.textField.keyboardType = configuration.keyboardType;
}

- (void)setAttributedText:(NSAttributedString *)text {
    self.textField.attributedText = text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

// MARK: - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField {
    block(self.onTextChange, textField.text);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    block(self.onBeginEditing);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
