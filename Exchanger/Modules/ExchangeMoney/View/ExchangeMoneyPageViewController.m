#import "ExchangeMoneyPageViewController.h"
#import "ExchangeMoneyCurrencyViewController.h"
#import "SafeBlocks.h"

@interface ExchangeMoneyPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation ExchangeMoneyPageViewController

// MARK: - ExchangeMoneyPageViewController

- (void)setViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    _viewData = viewData;
    
    if ([_viewData count] == 0)
        return;
    
    ExchangeMoneyCurrencyViewController *viewController = [[ExchangeMoneyCurrencyViewController alloc] initWithViewData:_viewData.firstObject index:0];
    
    [self.pageViewController setViewControllers:@[viewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
}

// MARK: - ViewController life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
    
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

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.viewData count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [((ExchangeMoneyCurrencyViewController *) viewController) pageIndex] - 1;
    
    if (index < 0) {
        index = [self.viewData count] - 1;
    }
    
    return [self viewControllerForIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [((ExchangeMoneyCurrencyViewController *) viewController) pageIndex] + 1;
    
    if (index >= [self.viewData count]) {
        index = 0;
    }
    
    return [self viewControllerForIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    __strong ExchangeMoneyCurrencyViewController *controller = [pageViewController.viewControllers firstObject];

    self.currentIndex = [controller pageIndex];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [controller becomeFirstResponder];
    }];
    
    ExchangeMoneyCurrencyViewData *viewData = [self.viewData objectAtIndex:self.currentIndex];
    
    executeIfNotNil(viewData.onShow);
}

// MARK: - FirstResponder

- (BOOL)becomeFirstResponder {
    
    ExchangeMoneyCurrencyViewController *controller = (ExchangeMoneyCurrencyViewController *)[self viewControllerForIndex:self.currentIndex];
    
    return [controller becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    ExchangeMoneyCurrencyViewController *controller = (ExchangeMoneyCurrencyViewController *)[self viewControllerForIndex:self.currentIndex];
    
    return [controller resignFirstResponder];
}

//- (BOOL)isFirstResponder {
//    ExchangeMoneyCurrencyViewController *controller = (ExchangeMoneyCurrencyViewController *)[self viewControllerForIndex:self.currentIndex];
//    
//    return [controller isFirstResponder];
//}

@end
