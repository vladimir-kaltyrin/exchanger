#import "CarouselController.h"
#import "CarouselPageData.h"
#import "CarouselPageController.h"
#import "CarouselPage.h"
#import "SafeBlocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarouselController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray<CarouselPageData *> *data;
@end

NS_ASSUME_NONNULL_END

@implementation CarouselController
    
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
    
- (void)setData:(NSArray<CarouselPageData *> *)data currentPage:(NSInteger)currentPage {

    _data = data;
    
    if ([self.data count] > 1) {
        self.delegate = self;
        self.dataSource = self;
    } else {
        self.delegate = nil;
        self.dataSource = nil;
    }
    
    UIViewController *firstController = [self viewControllerAt:currentPage];
    if (firstController != nil) {
        
        // UIKit has side effects if setViewControllers is called after transition completion.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setViewControllers:@[firstController]
                           direction:UIPageViewControllerNavigationDirectionForward
                            animated:NO
                          completion:nil];
        }];
    }
    
}
    
- (void)prepareForReuse {
    
    self.data = [NSArray array];
    self.delegate = nil;
    self.dataSource = nil;
}

- (void)focus {
    CarouselPageController *controller = (CarouselPageController *)[self viewControllerAt:[self currentPage]];
    [controller focus];
}
    
// MARK: - Private
    
- (nullable UIViewController *)viewControllerAt: (NSInteger)index {
    if (index < self.data.count) {
        CarouselPageData *pageData = [self.data objectAtIndex:index];
        CarouselPageController *controller = [[CarouselPageController alloc] initWithIndex:index data:pageData];
        controller.onPageWillChange = self.onPageWillChange;
        controller.checkCanFocus = self.checkCanFocus;
        controller.onViewDidAppear = self.onPageDidAppear;
        controller.onFocus = self.onFocus;
        
        return controller;
    }
    
    return nil;
}

- (NSInteger)nextIndexAfter:(NSInteger)index {
    return (index >= self.data.count - 1) ? 0 : index + 1;
}
    
- (NSInteger)nextIndexBefore:(NSInteger)index {
    return (index < 1) ? self.data.count - 1 : index - 1;
}
    
- (NSInteger)currentPage {
    UIViewController *firstController = self.viewControllers.firstObject;
    if ([firstController isKindOfClass:[CarouselPageController class]]) {
        NSInteger index = [((CarouselPageController *)firstController) index];
        return index;
    }
    return 0;
}
    
// MARK: - UIPageViewControllerDataSource
    
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(nonnull UIViewController *)viewController
{
    if (self.data.count > 1) {
        
        if ([viewController isKindOfClass:[CarouselPageController class]]) {
            NSInteger currentIndex = [((CarouselPageController *)viewController) index];
            
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
        
        if ([viewController isKindOfClass:[CarouselPageController class]]) {
            NSInteger currentIndex = [((CarouselPageController *)viewController) index];
            
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
    if ([firstController isKindOfClass:[CarouselPageController class]]) {
        CarouselPageController* currentController = (CarouselPageController *)firstController;
        NSInteger currentIndex = [currentController index];
        
        [currentController focus];
        
        block(self.onPageChange, currentIndex, self.data.count);
    }
}

@end
