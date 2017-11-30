#import "IntroPresenter.h"
#import "IntroInteractor.h"
#import "IntroRouter.h"

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

// MARK: - IntroModule

@end
