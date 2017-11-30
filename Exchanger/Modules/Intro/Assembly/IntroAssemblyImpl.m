#import "IntroAssemblyImpl.h"
#import "IntroViewController.h"
#import "IntroPresenter.h"
#import "IntroRouterImpl.h"
#import "IntroInteractorImpl.h"

@interface IntroAssemblyImpl()
@property (nonatomic, strong) IntroViewController *viewController;
@end

@implementation IntroAssemblyImpl

- (AssembledViewController *)module {
    return [[AssembledViewController alloc] initWithViewController:self.viewController
                                                            module:[self presenter]];
}

// MARK: - Private

- (id<IntroInteractor>)interactor {
    return [[IntroInteractorImpl alloc] init];
}

- (id<IntroRouter>)router {
    return [[IntroRouterImpl alloc] initWithAssemblyFactory:self.assemblyFactory
                                             viewController:self.viewController];
}

- (id<IntroModule>)presenter {
    IntroPresenter *presenter = [[IntroPresenter alloc] initWithInteractor:[self interactor]
                                                                    router:[self router]];
    presenter.view = [self viewController];
    
    return presenter;
}

- (IntroViewController *)viewController {
    if (_viewController == nil) {
        _viewController = [[IntroViewController alloc] init];
    }
    return _viewController;
}

@end
