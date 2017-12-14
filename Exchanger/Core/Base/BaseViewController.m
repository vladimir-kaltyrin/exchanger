#import "BaseViewController.h"
#import "SafeBlocks.h"
#import "DisposeBag.h"

@interface BaseViewController ()
@property (nonatomic, strong) DisposeBag *disposeBag;
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
    self.disposeBag = [[DisposeBag alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

// MARK: - ViewController Life-Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    block(self.onViewDidLoad)
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    block(self.onViewDidAppear)
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    block(self.onViewWillAppear)
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    block(self.onViewWillDisappear)
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    block(self.onViewDidDisappear)
}

// MARK: - DisposeBagHolder

- (void)addDisposable:(id)disposable {
    [self.disposeBag addDisposable:disposable];
}

@end
