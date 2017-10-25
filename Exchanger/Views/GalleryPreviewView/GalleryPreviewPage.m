#import "GalleryPreviewPage.h"
#import "ObservableImageView.h"
#import "GalleryPreviewPageData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPage()
@property (nonatomic, strong) ObservableImageView *imageView;
@property (nonatomic, strong, nullable) UIImage *placeholder;
@end

@implementation GalleryPreviewPage
    
// MARK: - Init
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:NO];
        self.imageView.clipsToBounds = YES;
        
        __weak typeof(self) weakSelf = self;
        self.imageView.onImageChange = ^(UIImage * _Nonnull nullable) {
            [weakSelf onImageChange];
        };
        
        [self addSubview:self.imageView];
    }
    return self;
}
    
// MARK: - Public
    
- (void)setViewData:(GalleryPreviewPageData *)data {
    self.placeholder = data.placeholder;
    self.imageView.image = self.placeholder;
}
    
- (void)prepareForReuse {
    self.placeholder = nil;
    self.imageView.image = nil;
}
    
// MARK: - Private
    
- (void)onImageChange {
    if (self.imageView.image == self.placeholder) {
        self.imageView.contentMode = UIViewContentModeCenter;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
NS_ASSUME_NONNULL_END
