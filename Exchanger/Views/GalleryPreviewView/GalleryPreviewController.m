#import "GalleryPreviewController.h"
#import "GalleryPreviewPageData.h"
#import "GalleryPreviewPageController.h"
#import "SafeBlocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray<GalleryPreviewPageData *> *data;
@end

NS_ASSUME_NONNULL_END

@implementation GalleryPreviewController
    
// MARK: - Init
    
- (instancetype)init {
    if (self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                      options:NULL])
    {
        self.data = [NSArray array];
    }
    return self;
}

// MARK: - Public
    
- (void)setData:(NSArray<GalleryPreviewPageData *> *)data {
    _data = data;
    
    if ([self.data count] > 1) {
        self.delegate = self;
        self.dataSource = self;
    } else {
        self.delegate = nil;
        self.dataSource = nil;
    }
    
    UIViewController *firstController = [self viewControllerAt:0];
    if (firstController != nil) {
        [self setViewControllers:@[firstController]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                       completion:nil];
    }
}
    
- (void)prepareForReuse {
    
    self.data = [NSArray array];
    self.delegate = nil;
    self.dataSource = nil;
}
    
// MARK: - Private
    
- (nullable UIViewController *)viewControllerAt: (NSInteger)index {
    if (self.data.count > index) {
        GalleryPreviewPageData *pageData = [self.data objectAtIndex:index];
        return [[GalleryPreviewPageController alloc] initWithIndex:index data:pageData];
    }
    
    return nil;
}

- (NSInteger)nextIndexAfter:(NSInteger)index {
    return (index + 1 >= self.data.count) ? 0 : index + 1;
}
    
- (NSInteger)nextIndexBefore:(NSInteger)index {
    return (index - 1 < 0) ? self.data.count - 1 : index - 1;
}
    
- (NSInteger)currentPage {
    UIViewController *firstController = self.viewControllers.firstObject;
    if ([firstController isKindOfClass:[GalleryPreviewPageController class]]) {
        NSInteger index = [((GalleryPreviewPageController *)firstController) index];
        return index + 1;
    }
    return 0;
}
    
// MARK: - UIPageViewControllerDataSource
    
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(nonnull UIViewController *)viewController
{
    if (self.data.count > 1) {
        
        if ([viewController isKindOfClass:[GalleryPreviewPageController class]]) {
            NSInteger currentIndex = [((GalleryPreviewPageController *)viewController) index];
            
            NSInteger index = [self nextIndexBefore:currentIndex];
            
            return [self viewControllerAt:index];
        }
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.data.count > 1) {
        
        if ([viewController isKindOfClass:[GalleryPreviewPageController class]]) {
            NSInteger currentIndex = [((GalleryPreviewPageController *)viewController) index];
            
            NSInteger index = [self nextIndexAfter:currentIndex];
            
            return [self viewControllerAt:index];
        }
    }
    
    return nil;
}
    
// MARK: - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    UIViewController *firstController = self.viewControllers.firstObject;
    if ([firstController isKindOfClass:[GalleryPreviewPageController class]]) {
        NSInteger currentIndex = [((GalleryPreviewPageController *)firstController) index];
        
        block(self.onPageChange, currentIndex, self.data.count)
    }
}

@end
