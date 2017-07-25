#import <Foundation/Foundation.h>
#import "ExchangeMoneyViewInput.h"
#import "ExchangeMoneyInteractor.h"
#import "ExchangeMoneyRouter.h"
#import "ExchangeMoneyModule.h"

@interface ExchangeMoneyPresenter : NSObject<ExchangeMoneyModule>
@property (nonatomic, weak) id<ExchangeMoneyViewInput> view;

- (instancetype)initWithInteractor:(id<ExchangeMoneyInteractor>)interactor
                            router:(id<ExchangeMoneyRouter>)router;

@end
