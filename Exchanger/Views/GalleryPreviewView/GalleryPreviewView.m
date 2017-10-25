#import "GalleryPreviewView.h"
#import "GalleryPreviewPageController.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewController.h"
#import "GalleryPreviewPageIndicator.h"
#import "SafeBlocks.h"
#import "MoveFailableLongPressGestureRecognizer.h"

@interface GalleryPreviewView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) void(^onTap)();
@property (nonatomic, strong) GalleryPreviewController *galleryPreview;
@property (nonatomic, strong) GalleryPreviewPageIndicator *pageIndicator;
@end

@implementation GalleryPreviewView
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.galleryPreview = [[GalleryPreviewController alloc] init];
        self.pageIndicator = [[GalleryPreviewPageIndicator alloc] init];
        
        __weak typeof(self) weakSelf = self;
        self.galleryPreview.onPageChange = ^(NSInteger current, NSInteger total) {
            [weakSelf.pageIndicator setCurrentPage:current ofTotal:total];
        };
        
        [self addSubview:self.galleryPreview.view];
        [self addSubview:self.pageIndicator];
        
        [self.pageIndicator setUserInteractionEnabled:NO];
        
        [self setupRecognizer];
    }
    
    return self;
}

- (void)prepareForReuse {
    [self.galleryPreview prepareForReuse];
    [self.pageIndicator setCurrentPage:0 ofTotal:0];
}
    
// MARK: - Public
    
- (void)setOnPageChange:(void (^)(NSInteger, NSInteger))onPageChange {
    self.galleryPreview.onPageChange = onPageChange;
}
    
- (void (^)(NSInteger, NSInteger))onPageChange {
    return self.galleryPreview.onPageChange;
}
    
- (void)setViewData:(GalleryPreviewData *)data {
    [self.pageIndicator setCurrentPage:0 ofTotal:data.pages.count];
    [self.galleryPreview setData:data.pages];
    self.onTap = data.onTap;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageIndicator.frame = self.bounds;
    self.galleryPreview.view.frame = self.bounds;
}
    
// MARK: - UIGestureRecognizerDelegate
    
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
    
// MARK: - Recognizers

- (void)setupRecognizer {
    MoveFailableLongPressGestureRecognizer *selectRecognizer = [[MoveFailableLongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                                       action:@selector(onSelect:)];
    selectRecognizer.minimumPressDuration = 0.1;
    selectRecognizer.allowableMovement = 1;
    selectRecognizer.allowableMovementAfterBegan = 1;
    selectRecognizer.delegate = self;
    
    [self addGestureRecognizer:selectRecognizer];
}
    
- (void)onSelect:(UIGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            executeIfNotNil(self.onSelect, YES);
            break;
        case UIGestureRecognizerStateEnded:
            executeIfNotNil(self.onSelect, NO);
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            executeIfNotNil(self.onSelect, NO);
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateChanged:
            break;
    }
}

@end
