#import "ExchangeMoneyView.h"
#import "ExchangeMoneyViewData.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeMoneyInputTextField.h"
#import "ExchangeMoneyCurrencyView.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewPageData.h"
#import "KeyboardData.h"
#import "CurrencyRateCell.h"
#import "ObservableTextField.h"
#import "FormatterFactoryImpl.h"
#import "UIView+Properties.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

NSString * const kCurrencyRateCellId = @"kCurrencyRateCellId";

CGFloat const kFontSize = 34.0;

@interface ExchangeMoneyView()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) ExchangeMoneyInputTextField *inputTextField;
@property (nonatomic, strong) ExchangeMoneyCurrencyView *sourceCurrencyView;
@property (nonatomic, strong) ExchangeMoneyCurrencyView *targetCurrencyView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@end

@implementation ExchangeMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:@"https://picsum.photos/800/600"]];
        
        self.overlayView = [[UIView alloc] initWithFrame:CGRectZero];
        self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
        
        self.sourceCurrencyView = [[ExchangeMoneyCurrencyView alloc] initWithStyle:ExchangeMoneyCurrencViewStyleSource];
        self.targetCurrencyView = [[ExchangeMoneyCurrencyView alloc] initWithStyle:ExchangeMoneyCurrencViewStyleTarget];
        
        self.stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.sourceCurrencyView, self.targetCurrencyView]];
        self.stackView.alignment = UIStackViewAlignmentLeading;
        self.stackView.axis = UILayoutConstraintAxisVertical;
        self.stackView.translatesAutoresizingMaskIntoConstraints = YES;
        self.stackView.distribution = UIStackViewDistributionFillEqually;
        
        self.inputTextField = [[ExchangeMoneyInputTextField alloc] init];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.overlayView];
        [self addSubview:self.stackView];
        [self addSubview:self.inputTextField];
        [self addSubview:self.activityIndicator];
    }
    
    return self;
}

// MARK: - ExchangeMoneyView

- (void)focusOnStart {
    [self.inputTextField becomeFirstResponder];
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    self.keyboardHeight = keyboardData.size.height;

    [self setNeedsLayout];
}

- (void)setViewData:(ExchangeMoneyViewData *)viewData {
    [self configureCurrencyView:self.sourceCurrencyView
                          model:viewData.sourceData
                   exchangeType:CurrencyExchangeSourceType];
    
    [self configureCurrencyView:self.targetCurrencyView
                          model:viewData.sourceData
                   exchangeType:CurrencyExchangeTargetType];
    
    [self setNeedsLayout];
}

- (void)startActivity {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivity {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    self.overlayView.frame = self.bounds;
    self.activityIndicator.center = self.center;
    
    CGRect contentsFrame = [self contentsFrame];
    
    self.stackView.frame = contentsFrame;
    
    self.sourceCurrencyView.width = contentsFrame.size.width;
    self.sourceCurrencyView.height = contentsFrame.size.height / 2;
    
    self.targetCurrencyView.width = contentsFrame.size.width;
    self.targetCurrencyView.height = contentsFrame.size.height / 2;
    
    self.inputTextField.width = 190;
    self.inputTextField.height = 70;
    self.inputTextField.right = 360;
    self.inputTextField.top = 16;
}

- (CGRect)contentsFrame {
    CGRect frame = self.bounds;
    frame.size.height = frame.size.height - self.keyboardHeight;
    return frame;
}

// MARK: - Private

- (void)configureCurrencyView:(ExchangeMoneyCurrencyView *)view
                        model:(GalleryPreviewData *)model
                 exchangeType:(CurrencyExchangeType)currencyExchangeType
{
    [view updateWithModel:model];
    
    __weak typeof(self) weakSelf = self;
    [view setOnPageChange:^(NSInteger current) {
        weakSelf.onPageChange(currencyExchangeType, current);
    }];
}
@end
