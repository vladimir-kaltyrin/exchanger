#import "ExchangeMoneyAssemblyImpl.h"
#import "ExchangeMoneyInteractor.h"
#import "ExchangeMoneyInteractorImpl.h"
#import "ExchangeMoneyModule.h"
#import "ExchangeMoneyPresenter.h"
#import "ExchangeMoneyRouter.h"
#import "ExchangeMoneyViewInput.h"
#import "ExchangeMoneyViewController.h"

@interface ExchangeMoneyAssemblyImpl()
@property (nonatomic, strong) ExchangeMoneyViewController *viewController;
@end

@implementation ExchangeMoneyAssemblyImpl

- (AssembledViewController *)module {
    return [[AssembledViewController alloc] initWithViewController:self.viewController
                                                            module:[self presenter]];
}

// MARK: - Private

- (id<ExchangeMoneyInteractor>)interactor {
    return [[ExchangeMoneyInteractorImpl alloc] initWithUser:nil
                                        exchangeMoneyService:[self.serviceFactory exchangeMoneyService]
                                        exchangeRatesUpdater:[self.serviceFactory exchangeRatesUpdater]
            ];
}

- (id<ExchangeMoneyRouter>)router {
    return [[ExchangeMoneyRouterImpl alloc] init];
}

- (id<ExchangeMoneyModule>)presenter {
    ExchangeMoneyPresenter *presenter = [[ExchangeMoneyPresenter alloc] initWithInteractor:[self interactor]
                                                                                    router:[self router]
                                                                          keyboardObserver:[self.serviceFactory keyboardObserver]];
    presenter.view = [self viewController];
    
    return presenter;
}

- (ExchangeMoneyViewController *)viewController {
    if (_viewController == nil) {
        _viewController = [[ExchangeMoneyViewController alloc] init];
    }
    return _viewController;
}

@end
