#import "ExchangeMoneyView.h"
#import "ExchangeMoneyViewData.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeMoneyInputTextField.h"
#import "ExchangeMoneyCurrencyView.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewPageData.h"
#import "KeyboardData.h"
#import "ObservableTextField.h"
#import "FormatterFactoryImpl.h"
#import "SafeBlocks.h"
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
        
        self.sourceCurrencyView = [[ExchangeMoneyCurrencyView alloc] initWithCurrencyExchangeType:CurrencyExchangeSourceType];
        self.targetCurrencyView = [[ExchangeMoneyCurrencyView alloc] initWithCurrencyExchangeType:CurrencyExchangeTargetType];
        
        self.inputTextField = [[ExchangeMoneyInputTextField alloc] init];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.overlayView];
        //[self addSubview:self.inputTextField];
        
        [self addSubview:self.sourceCurrencyView];
        [self addSubview:self.targetCurrencyView];
        [self addSubview:self.activityIndicator];
    }
    
    return self;
}

// MARK: - ExchangeMoneyView

- (void)focusOnStart {
    [self focusOnSourceView];
    
    __weak typeof(self) weakSelf = self;
    [self.sourceCurrencyView setOnFocus:^{
        [weakSelf focusOnSourceView];
    }];
    
    [self.targetCurrencyView setOnFocus:^{
        [weakSelf focusOnTargetView];
    }];
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    self.keyboardHeight = keyboardData.size.height;

    [self setNeedsLayout];
}

- (void)setViewData:(ExchangeMoneyViewData *)viewData {
    [self.sourceCurrencyView updateWithModel:viewData.sourceData];
    [self.targetCurrencyView updateWithModel:viewData.targetData];
    
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

- (void)setOnPageChange:(void (^)(CurrencyExchangeType, NSInteger))onPageChange {
    [self.sourceCurrencyView setOnPageChange:onPageChange];
    [self.targetCurrencyView setOnPageChange:onPageChange];
}

- (void)setOnInputChange:(void (^)(NSString *))onInputChange {
    [self.inputTextField setOnInputChange:onInputChange];
}

// MARK: - Private

- (void)focusOnSourceView {
    [self.sourceCurrencyView setFocusEnabled:YES];
    [self.targetCurrencyView setFocusEnabled:NO];
}

- (void)focusOnTargetView {
    [self.sourceCurrencyView setFocusEnabled:NO];
    [self.targetCurrencyView setFocusEnabled:YES];
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    self.overlayView.frame = self.bounds;
    self.activityIndicator.center = self.center;
    
    CGRect contentsFrame = [self contentsFrame];
    
    self.sourceCurrencyView.width = contentsFrame.size.width;
    self.sourceCurrencyView.height = contentsFrame.size.height / 2;
    
    self.targetCurrencyView.width = contentsFrame.size.width;
    self.targetCurrencyView.height = contentsFrame.size.height / 2;
    self.targetCurrencyView.top = self.sourceCurrencyView.bottom;
    
    self.inputTextField.frame = CGRectZero;
}

- (CGRect)contentsFrame {
    CGRect frame = self.bounds;
    frame.size.height = frame.size.height - self.keyboardHeight;
    return frame;
}

@end
