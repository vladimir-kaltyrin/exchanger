#import "IntroViewController.h"
#import "IntroView.h"

@interface IntroViewController ()
@property (nonatomic, strong) IntroView *introView;
@end

@implementation IntroViewController

// MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        self.introView = [[IntroView alloc] init];
    }
    
    return self;
}

// MARK: - ViewController Life-Cycle

- (void)loadView {
    self.view = self.introView;
}

// MARK: - IntroViewInput



@end
