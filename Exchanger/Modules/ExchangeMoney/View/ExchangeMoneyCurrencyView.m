#import "ExchangeMoneyCurrencyView.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "ExchangeMoneyBalanceViewData.h"
#import "UIView+Properties.h"
#import "SafeBlocks.h"

// MARK: - Private consts

CGFloat const kBigFontSize = 24.0;
CGFloat const kMediumFontSize = 20.0;
CGFloat const kSmallFontSize = 10.0;

@interface ExchangeMoneyCurrencyView()
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UITextField *exchangeTextField;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) void(^onTextChange)();
@end

@implementation ExchangeMoneyCurrencyView

// MARK: - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - Private methods

- (void)setup
{
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.balanceLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
    [self addSubview:self.balanceLabel];
    
    self.currencyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.currencyLabel.textColor = [UIColor whiteColor];
    self.currencyLabel.font = [UIFont systemFontOfSize:kBigFontSize];
    [self addSubview:self.currencyLabel];
    
    self.exchangeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.exchangeTextField.textColor = [UIColor whiteColor];
    self.exchangeTextField.font = [UIFont systemFontOfSize:kBigFontSize];
    self.exchangeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.exchangeTextField];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.rateLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.rateLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
    [self addSubview:self.rateLabel];
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note)
    {
        executeIfNotNil(weakSelf.onTextChange);
    }];
}

- (void)setBalance:(ExchangeMoneyBalanceViewData *)balance
{
    switch (balance.balanceType)
    {
        case Normal:
            self.balanceLabel.textColor = [UIColor whiteColor];
            break;
        case Insufficient:
            self.balanceLabel.textColor = [UIColor redColor];
            break;
    }
    
    self.balanceLabel.text = balance.balanceValue;
}

- (void)setCurrency:(NSString *)currency {
    self.currencyLabel.text = currency;
}

- (void)setRate:(NSString *)rate {
    
    self.rateLabel.text = rate;
}

- (void)setExchange:(NSString *)exchange {
    self.exchangeTextField.text = exchange;
}

// MARK: - Helpers

- (UIEdgeInsets)contentInsets {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (CGFloat)verticalOffsetBetweenLabels {
    return 12;
}

// MARK: - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, [self contentInsets]);
    
    CGSize currencyLabelSize = [self.currencyLabel sizeThatFits:contentFrame.size];
    self.currencyLabel.size = currencyLabelSize;
    self.currencyLabel.left = contentFrame.origin.x;
    self.currencyLabel.top = contentFrame.origin.y;
    
    CGSize balanceLabelSize = [self.balanceLabel sizeThatFits:contentFrame.size];
    self.balanceLabel.size = balanceLabelSize;
    self.balanceLabel.top = self.currencyLabel.bottom + [self verticalOffsetBetweenLabels];
    self.balanceLabel.left = self.currencyLabel.x;
    
    CGSize exchangeTextFieldSize = [self.currencyLabel sizeThatFits:contentFrame.size];
    self.exchangeTextField.size = exchangeTextFieldSize;
    self.exchangeTextField.right = contentFrame.origin.x + contentFrame.size.width;
    self.exchangeTextField.top = contentFrame.origin.y;
    
    CGSize rateLabelSize = [self.rateLabel sizeThatFits:contentFrame.size];
    self.rateLabel.size = rateLabelSize;
    self.rateLabel.right = self.exchangeTextField.right;
    self.rateLabel.top = self.exchangeTextField.bottom + [self verticalOffsetBetweenLabels];
}

// MARK: - FirstResponder

- (BOOL)becomeFirstResponder {
    return [self.exchangeTextField becomeFirstResponder];
}

- (BOOL)isFirstResponder {
    return [self.exchangeTextField isFirstResponder];
}

// MARK: - ExchangeMoneyCurrencyView

- (void)setViewData:(ExchangeMoneyCurrencyViewData *)viewData
{
    [self setBalance:viewData.balance];
    [self setCurrency:viewData.currency];
    
    [self setOnTextChange:viewData.onTextChange];
    
    [self setNeedsLayout];
}

@end
