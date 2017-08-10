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

// MARK: - Init

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUp];
    }
    return self;
}

// MARK: - Private

- (void)setUp {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

// MARK: - ViewController Life-Cycle

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
