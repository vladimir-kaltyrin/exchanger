#import "CurrencyRateCell.h"
#import "GalleryPreviewView.h"
#import "GalleryPreviewData.h"

@interface CurrencyRateCell()
@property (nonatomic, strong) GalleryPreviewView *previewView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation CurrencyRateCell

- (instancetype)initWithStyle:(CurrencyRateCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.previewView = [[GalleryPreviewView alloc] initWithFrame:CGRectZero];
        
        UIBlurEffectStyle blurEffectStyle;
        switch (style) {
        case CurrencyRateCellStyleLight:
            blurEffectStyle = UIBlurEffectStyleLight;
            break;
        case CurrencyRateCellStyleDark:
            blurEffectStyle = UIBlurEffectStyleDark;
            break;
        }
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:blurEffectStyle]];
    
        [self addSubview:self.visualEffectView];
        [self addSubview:self.previewView];

        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
    
- (void)updateWithModel:(GalleryPreviewData *)model {
    [self.previewView setViewData:model];
}

- (void)setOnPageChange:(void(^)(NSInteger current))onPageChange {
    [self.previewView setOnPageChange:onPageChange];
}

- (void)setCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType {
    
}

// MARK: - Layout
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.visualEffectView.frame = self.bounds;
    self.previewView.frame = self.bounds;
}

@end
