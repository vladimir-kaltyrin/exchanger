#import <Foundation/Foundation.h>
#import "IntroModule.h"
#import "IntroViewInput.h"
#import "IntroInteractor.h"
#import "IntroRouter.h"

@interface IntroPresenter : NSObject<IntroModule>
@property (nonatomic, weak) id<IntroViewInput> view;

- (instancetype)initWithInteractor:(id<IntroInteractor>)interactor
                            router:(id<IntroRouter>)router;

@end
