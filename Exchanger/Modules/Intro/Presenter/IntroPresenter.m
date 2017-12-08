#import "IntroPresenter.h"

@interface IntroPresenter()
@property (nonatomic, strong) id<IntroInteractor> interactor;
@property (nonatomic, strong) id<IntroRouter> router;
@end

@implementation IntroPresenter

// MARK: - Init

- (instancetype)initWithInteractor:(id<IntroInteractor>)interactor
                            router:(id<IntroRouter>)router
{
    self = [super init];
    if (self) {
        self.interactor = interactor;
        self.router = router;
    }
    
    return self;
}

// MARK: - Public

- (void)setView:(id<IntroViewInput>)view {
    _view = view;
    
    [self setUpView];
}

// MARK: - Private

- (void)setUpView {
    
    [self.view setTitle:@"Exchange your currencies easily!"];
    
    [self.view setStartButtonTitle:@"Start Demo"];
    [self.view setResetButtonTitle:@"About"];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view setOnStartTap:^{
        [weakSelf.router showDemoWith:^(id<ExchangeMoneyModule> module) {
            __weak typeof(module) weakModule = module;
            module.onFinish = ^{
                [weakModule dismissModule];
            };
        }];
    }];
    
    [self.view setOnBackTap:^{
        [weakSelf.router showAbout];
    }];
}

@end
