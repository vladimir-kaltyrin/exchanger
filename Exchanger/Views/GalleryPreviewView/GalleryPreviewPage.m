#import "GalleryPreviewPage.h"
#import "GalleryPreviewPageData.h"
#import "UIView+Properties.h"

CGFloat const kBigFontSize = 34.0;
CGFloat const kSmallFontSize = 12.0;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPage()
@property (nonatomic, strong) UILabel *currencyTitleLabel;
@property (nonatomic, strong) UITextField *currencyAmountTextField;
@property (nonatomic, strong) UILabel *remainderLabel;
@property (nonatomic, strong) UILabel *currencyRateLabel;
@end

@implementation GalleryPreviewPage
    
// MARK: - Init
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.currencyTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currencyTitleLabel.font = [UIFont systemFontOfSize:kBigFontSize];
        self.currencyTitleLabel.textColor = [UIColor whiteColor];
        
        self.currencyAmountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.currencyAmountTextField.font = [UIFont systemFontOfSize:kBigFontSize];
        self.currencyAmountTextField.textColor = [UIColor whiteColor];
        self.currencyAmountTextField.textAlignment = NSTextAlignmentRight;
        
        self.remainderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.remainderLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        self.remainderLabel.textColor = [UIColor whiteColor];
        
        self.currencyRateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currencyRateLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        self.currencyRateLabel.textColor = [UIColor whiteColor];
        self.currencyRateLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.currencyTitleLabel];
        [self addSubview:self.currencyAmountTextField];
        [self addSubview:self.remainderLabel];
        [self addSubview:self.currencyRateLabel];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
    
// MARK: - Helpers
    
- (UIEdgeInsets)contentInsets {
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (BOOL)isFirstResponder {
    return [self.currencyAmountTextField isFirstResponder];
}

- (BOOL)becomeFirstResponder {
    return [self.currencyAmountTextField becomeFirstResponder];
}
    
// MARK: - Public
    
- (void)setViewData:(GalleryPreviewPageData *)data {
    self.currencyTitleLabel.text = data.currencyTitle;
    self.currencyAmountTextField.text = data.currencyAmount;
    self.remainderLabel.text = data.remainder;
    self.currencyRateLabel.text = data.rate;
}
    
- (void)prepareForReuse {
    self.currencyTitleLabel.text = nil;
    self.currencyAmountTextField.text = nil;
    self.remainderLabel.text = nil;
    self.currencyRateLabel.text = nil;
}
    
// MARK: - Private
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.bounds, [self contentInsets]);
    CGFloat verticalOffsetBetweenLabels = 12.f;
    
    CGSize currencyTitleLabelSize = [self.currencyTitleLabel sizeThatFits:contentFrame.size];
    self.currencyTitleLabel.size = currencyTitleLabelSize;
    self.currencyTitleLabel.left = contentFrame.origin.x;
    self.currencyTitleLabel.top = contentFrame.origin.y;
    
    CGSize remainderLabelSize = [self.remainderLabel sizeThatFits:contentFrame.size];
    self.remainderLabel.size = remainderLabelSize;
    self.remainderLabel.top = self.currencyTitleLabel.bottom + verticalOffsetBetweenLabels;
    self.remainderLabel.left = self.currencyTitleLabel.x;
    
    self.currencyAmountTextField.width = 190;
    self.currencyAmountTextField.height = self.currencyTitleLabel.height;
    self.currencyAmountTextField.right = contentFrame.origin.x + contentFrame.size.width;
    self.currencyAmountTextField.top = self.currencyTitleLabel.top;
    
    CGSize currencyRateLabelSize = [self.currencyRateLabel sizeThatFits:contentFrame.size];
    self.currencyRateLabel.size = currencyRateLabelSize;
    self.currencyRateLabel.right = self.currencyAmountTextField.right;
    self.currencyRateLabel.top = self.remainderLabel.top;
}

@end

NS_ASSUME_NONNULL_END
