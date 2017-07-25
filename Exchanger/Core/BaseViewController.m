#import "BaseViewController.h"
#import "SafeBlocks.h"

@interface BaseViewController ()
@end

@implementation BaseViewController
@synthesize onViewDidLoad;
@synthesize onViewDidAppear;
@synthesize onViewWillAppear;
@synthesize onViewWillDisappear;
@synthesize onViewDidDisappear;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    executeIfNotNil(self.onViewDidLoad)
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    executeIfNotNil(self.onViewDidAppear)
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    executeIfNotNil(self.onViewWillAppear)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    executeIfNotNil(self.onViewWillDisappear)
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    executeIfNotNil(self.onViewDidDisappear)
}

@end
