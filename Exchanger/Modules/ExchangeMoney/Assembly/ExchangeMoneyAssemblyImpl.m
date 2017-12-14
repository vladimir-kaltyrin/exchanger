#import "ExchangeMoneyAssemblyImpl.h"
#import "ExchangeMoneyInteractor.h"
#import "ConvenientObjC.h"
#import "ExchangeMoneyInteractorImpl.h"
#import "ExchangeMoneyModule.h"
#import "ExchangeMoneyPresenter.h"
#import "ExchangeMoneyRouter.h"
#import "ExchangeMoneyViewInput.h"
#import "ExchangeMoneyViewController.h"
#import "User.h"

@interface ExchangeMoneyAssemblyImpl()
@property (nonatomic, strong) ExchangeMoneyViewController *viewController;
@end

@implementation ExchangeMoneyAssemblyImpl

- (AssembledViewController *)module {
    
    self.viewController = [[ExchangeMoneyViewController alloc] init];
    
    let presenter = [self presenter];
    [self.viewController addDisposable:presenter];
    
    return [[AssembledViewController alloc] initWithViewController:self.viewController
                                                            module:presenter];
}

// MARK: - Private

- (id<ExchangeMoneyInteractor>)interactor {
    return [[ExchangeMoneyInteractorImpl alloc] initWithUserService:[self.serviceFactory userService]
                                               exchangeRatesService:[self.serviceFactory exchangeRatesService]
                                               exchangeMoneyService:[self.serviceFactory exchangeMoneyService]
                                               exchangeRatesUpdater:[self.serviceFactory exchangeRatesUpdater]
            ];
}

- (id<ExchangeMoneyRouter>)router {
    return [[ExchangeMoneyRouterImpl alloc] initWithAssemblyFactory:self.assemblyFactory viewController:self.viewController];
}

- (id<ExchangeMoneyModule>)presenter {
    var presenter = [[ExchangeMoneyPresenter alloc] initWithInteractor:[self interactor]
                                                                router:[self router]
                                                      keyboardObserver:[self.serviceFactory keyboardObserver]];
    presenter.view = [self viewController];
    
    return presenter;
}

@end
