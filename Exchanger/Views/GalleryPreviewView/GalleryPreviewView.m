#import "GalleryPreviewView.h"
#import "GalleryPreviewPageController.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewController.h"
#import "MoveFailableLongPressGestureRecognizer.h"

@interface GalleryPreviewView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) void(^onTap)();
@property (nonatomic, strong) GalleryPreviewData *currentData;
@property (nonatomic, strong) GalleryPreviewController *galleryPreview;
@end

@implementation GalleryPreviewView
    
- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
        self.galleryPreview = [[GalleryPreviewController alloc] init];
        
        [self addSubview:self.galleryPreview.view];
        
        [self setupRecognizer];
    }
    
    return self;
}

- (void)prepareForReuse {
    [self.galleryPreview prepareForReuse];
}
    
// MARK: - Public
    
- (void)setOnPageChange:(void (^)(NSInteger, NSInteger))onPageChange {
    self.galleryPreview.onPageChange = onPageChange;
}
    
- (void (^)(NSInteger, NSInteger))onPageChange {
    return self.galleryPreview.onPageChange;
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
            self.onSelect(YES);
            break;
        case UIGestureRecognizerStateEnded:
            self.onSelect(NO);
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            self.onSelect(NO);
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateChanged:
            break;
    }
}

@end
