#import "GalleryPreviewPage.h"
#import "ObservableImageView.h"
#import "GalleryPreviewPageData.h"
#import "UIView+Properties.h"
#import <UIImageView+AFNetworking.h>

CGFloat const kBigFontSize = 34.0;
CGFloat const kSmallFontSize = 12.0;

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPage()
@property (nonatomic, strong) ObservableImageView *imageView;
@property (nonatomic, strong) UILabel *currencyTitleLabel;
@property (nonatomic, strong) UITextField *currencyAmountTextField;
@property (nonatomic, strong) UILabel *remainderLabel;
@property (nonatomic, strong) UILabel *currencyRateLabel;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation GalleryPreviewPage
    
// MARK: - Init
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:NO];
        
        self.currencyTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currencyTitleLabel.font = [UIFont systemFontOfSize:kBigFontSize];
        self.currencyTitleLabel.textColor = [UIColor whiteColor];
        
        self.currencyAmountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.currencyAmountTextField.font = [UIFont systemFontOfSize:kBigFontSize];
        self.currencyAmountTextField.textColor = [UIColor whiteColor];
        
        self.remainderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.remainderLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        self.remainderLabel.textColor = [UIColor whiteColor];
        
        self.currencyRateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currencyRateLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        self.currencyRateLabel.textColor = [UIColor whiteColor];
        
        self.imageView = [[ObservableImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect
                                                                            effectWithStyle:UIBlurEffectStyleDark]];
        
        
        __weak typeof(self) weakSelf = self;
        self.imageView.onImageChange = ^(UIImage * _Nonnull nullable) {
            [weakSelf onImageChange];
        };
        
        [self addSubview:self.imageView];
        [self addSubview:self.visualEffectView];
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
    
// MARK: - Public
    
- (void)setViewData:(GalleryPreviewPageData *)data {
    [self.imageView setImageWithURL:[NSURL URLWithString:data.imageUrl]];
    
    self.currencyTitleLabel.text = data.currencyTitle;
    self.currencyAmountTextField.text = data.currencyAmount;
    self.remainderLabel.text = data.remainder;
    self.currencyRateLabel.text = data.rate;
}
    
- (void)prepareForReuse {
    [self.imageView cancelImageDownloadTask];
    self.imageView.image = nil;
    self.currencyTitleLabel.text = nil;
    self.currencyAmountTextField.text = nil;
    self.remainderLabel.text = nil;
    self.currencyRateLabel.text = nil;
}
    
// MARK: - Private
    
- (void)onImageChange {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    self.visualEffectView.frame = self.bounds;
    
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
    self.currencyAmountTextField.height = 90;
    self.currencyAmountTextField.right = contentFrame.origin.x + contentFrame.size.width;
    self.currencyAmountTextField.top = contentFrame.origin.y;
    
    CGSize currencyRateLabelSize = [self.currencyRateLabel sizeThatFits:contentFrame.size];
    self.currencyRateLabel.size = currencyRateLabelSize;
    self.currencyRateLabel.right = self.currencyAmountTextField.right;
    self.currencyRateLabel.top = self.currencyAmountTextField.bottom + verticalOffsetBetweenLabels;
}

@end

NS_ASSUME_NONNULL_END
