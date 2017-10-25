#import "CurrencyRateCell.h"
#import "GalleryPreviewView.h"
#import "GalleryPreviewData.h"

@interface CurrencyRateCell()
@property (nonatomic, strong) GalleryPreviewView *previewView;
@end

@implementation CurrencyRateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.previewView = [[GalleryPreviewView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.previewView];
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}
    
- (void)updateWithModel:(GalleryPreviewData *)model {
    [self.previewView setViewData:model];
}

// MARK: - Layout
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.previewView.frame = self.bounds;
}

@end
