#import "GalleryPreviewView.h"
#import "GalleryPreviewPageController.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewController.h"
#import "GalleryPreviewPageIndicator.h"
#import "UITextField+Configuration.h"
#import "SafeBlocks.h"
#import "MoveFailableLongPressGestureRecognizer.h"

@interface GalleryPreviewView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) void(^onTap)();
@property (nonatomic, strong) GalleryPreviewController *galleryPreview;
@property (nonatomic, strong) GalleryPreviewPageIndicator *pageIndicator;
@property (nonatomic, strong) UITextField *firstResponderTextField;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL focusOnStart;
@property (nonatomic, assign) BOOL focusEnabled;
@end

@implementation GalleryPreviewView
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.galleryPreview = [[GalleryPreviewController alloc] init];
        [self addSubview:self.galleryPreview.view];
        
        self.pageIndicator = [[GalleryPreviewPageIndicator alloc] init];
        [self.pageIndicator setUserInteractionEnabled:NO];
        [self addSubview:self.pageIndicator];
        
        // There is a special trick to avoid hiding keyboard during scrolling in UIPageViewController.
        // The fake UITextField is added to the view and it's become first responder when page view controller resign its responders.
        self.firstResponderTextField = [[UITextField alloc] init];
        self.firstResponderTextField.keyboardType = [TextFieldConfiguration inputConfiguration].keyboardType;
        self.firstResponderTextField.hidden = YES;
        [self addSubview:self.firstResponderTextField];
        
        __weak typeof(self) weakSelf = self;
        [self.galleryPreview setOnPageWillChange:^{
            [weakSelf.firstResponderTextField becomeFirstResponder];
        }];
        
        [self.galleryPreview setCheckCanFocus:^BOOL(NSInteger page) {
            return weakSelf.focusEnabled;
        }];
        
        [self setupRecognizer];
    }
    
    return self;
}

- (void)prepareForReuse {
    [self.galleryPreview prepareForReuse];
    [self.pageIndicator setCurrentPage:0 ofTotal:0];
}
    
// MARK: - Public
    
- (void)setOnPageChange:(void (^)(NSInteger))onPageChange {
    _onPageChange = onPageChange;
    
    __weak typeof(self) weakSelf = self;
    self.galleryPreview.onPageChange = ^(NSInteger current, NSInteger total) {
        [weakSelf.pageIndicator setCurrentPage:current ofTotal:total];
        weakSelf.onPageChange(current);
    };
}

- (void)setOnPageWillChange:(void (^)())onPageWillChange {
    
}

- (void)setOnFocus:(void (^)())onFocus {
    [self.galleryPreview setOnFocus:onFocus];
}

- (void)setOnPageDidAppear:(void (^)())onPageDidAppear {
    [self.galleryPreview setOnPageDidAppear:onPageDidAppear];
}
    
- (void)setViewData:(GalleryPreviewData *)data {
    self.currentPage = data.currentPage;
    [self.pageIndicator setCurrentPage:data.currentPage ofTotal:data.pages.count];
    [self.galleryPreview setData:data.pages currentPage:data.currentPage];
    
    self.onTap = data.onTap;
}

- (void)focus {
    self.focusOnStart = YES;
}

- (void)setFocusEnabled:(BOOL)focusEnabled {
    _focusEnabled = focusEnabled;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageIndicator.frame = self.bounds;
    self.galleryPreview.view.frame = self.bounds;

    self.firstResponderTextField.frame = CGRectZero;
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
            block(self.onSelect, YES);
            break;
        case UIGestureRecognizerStateEnded:
            block(self.onSelect, NO);
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            block(self.onSelect, NO);
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateChanged:
            break;
    }
}

@end
