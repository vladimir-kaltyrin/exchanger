#import "ExchangeMoneyInputTextField.h"
#import "FormatterFactoryImpl.h"
#import "ObservableTextField.h"

@interface ExchangeMoneyInputTextField()
@property (nonatomic, strong) id<NumbersFormatter> numbersFormatter;
@property (nonatomic, strong) id<BalanceFormatter> exchangeCurrencyInputFormatter;
@property (nonatomic, strong) ObservableTextField *textField;
@end

@implementation ExchangeMoneyInputTextField

// MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.numbersFormatter = [[FormatterFactoryImpl instance] numbersFormatter];
        self.exchangeCurrencyInputFormatter = [[FormatterFactoryImpl instance] exchangeCurrencyInputFormatter];
        self.textField = [[ObservableTextField alloc] init];
        
        [self addSubview:self.textField];
        
        [self configureTextField];
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

- (void)setText:(NSString *)text {
    [self formatText:text];
}

// MARK: - Private

- (void)configureTextField {
    
    TextFieldConfiguration *configuration = [[TextFieldConfiguration alloc] init];
    configuration.font = [UIFont systemFontOfSize:17];
    configuration.textColor = [UIColor whiteColor];
    configuration.textAlignment = NSTextAlignmentRight;
    configuration.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.textField setConfiguration:configuration];
    
    __weak typeof(self) weakSelf = self;
    self.textField.onTextChange = ^BOOL(NSString *text) {
        [weakSelf formatText:text];
        
        return NO;
    };
}

- (void)formatText:(NSString *)text {
    NSString *numberText = [self.numbersFormatter format:text];
    NSAttributedString *formattedText = [self.exchangeCurrencyInputFormatter attributedFormatBalance:numberText];
    
    [self.textField setAttributedText:formattedText];
}

@end
