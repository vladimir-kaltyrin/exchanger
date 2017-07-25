#import "ExchangeMoneyPresenter.h"

@interface ExchangeMoneyPresenter()
@property (nonatomic, strong) id<ExchangeMoneyInteractor> interactor;
@property (nonatomic, strong) id<ExchangeMoneyRouter> router;
@end

@implementation ExchangeMoneyPresenter

- (instancetype)initWithInteractor:(id<ExchangeMoneyInteractor>)interactor
                            router:(id<ExchangeMoneyRouter>)router
{
    self = [super init];
    if (self) {
        self.interactor = interactor;
        self.router = router;
    }
    
    return self;
}

- (void)setView:(id<ExchangeMoneyViewInput>)view {
    _view = view;
    
    [self setUpView];
}

// MARK: - Private

- (void)setUpView {
    
    __weak typeof(self) weakSelf = self;
    
    [self.view setOnViewDidLoad:^{
        [weakSelf.view startActivity];
        [weakSelf.interactor startFetching];
    }];
    
    [self.interactor setOnUpdate:^{
        [weakSelf.view stopActivity];
    }];
}

@end
