#import "CurrencyRateCell.h"
#import "GalleryPreviewView.h"
#import "GalleryPreviewData.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CurrencyRateCell()
@property (nonatomic, strong) GalleryPreviewView *previewView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation CurrencyRateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.previewView = [[GalleryPreviewView alloc] initWithFrame:CGRectZero];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.visualEffectView];
        [self addSubview:self.previewView];
        
        self.backgroundImageView.backgroundColor = [UIColor blueColor];
    }
    return self;
}
    
- (void)updateWithModel:(GalleryPreviewData *)model {
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:@"https://picsum.photos/800/600"]];
    
    [self.previewView setViewData:model];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.backgroundImageView.image = nil;
    [self.imageView cancelImageDownloadTask];
}

// MARK: - Layout
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    self.visualEffectView.frame = self.bounds;
    self.previewView.frame = self.bounds;
}

@end
