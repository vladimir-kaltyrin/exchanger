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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

// MARK: - IntroViewInput

- (void)setOnResetTap:(void (^)())onBackTap {
    self.introView.onResetTap = onBackTap;
}

- (void (^)())onBackTap {
    return self.introView.onResetTap;
}

- (void)setOnStartTap:(void (^)())onStartTap {
    self.introView.onStartTap = onStartTap;
}

- (void (^)())onStartTap {
    return self.introView.onStartTap;
}

- (void)setResetButtonTitle:(NSString *)resetButtonTitle {
    [self.introView setResetButtonTitle:resetButtonTitle];
}

- (void)setStartButtonTitle:(NSString *)startButtonTitle {
    [self.introView setStartButtonTitle:startButtonTitle];
}

@end
