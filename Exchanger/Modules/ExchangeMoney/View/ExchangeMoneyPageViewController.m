#import "ExchangeMoneyPageViewController.h"
#import "ExchangeMoneyCurrencyViewController.h"

@interface ExchangeMoneyPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ExchangeMoneyPageViewController

// MARK: - ViewController life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
    
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    [self.pageViewController didMoveToParentViewController:self];
}

// MARK: - Lazy

- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    return _pageViewController;
}

// MARK: - Private

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    
    if ([self.viewData count] <= index)
        return nil;
    
    return [[ExchangeMoneyCurrencyViewController alloc] initWithViewData:self.viewData[index]
                                                                   index:index];
}

// MARK: - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger newIndex = [((ExchangeMoneyCurrencyViewController *) viewController) pageIndex] - 1;
    return [self viewControllerForIndex:newIndex];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger newIndex = [((ExchangeMoneyCurrencyViewController *) viewController) pageIndex] + 1;
    return [self viewControllerForIndex:newIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}

@end
