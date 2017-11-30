#import <Foundation/Foundation.h>
#import "IntroModule.h"
#import "IntroViewInput.h"

@interface IntroPresenter : NSObject<IntroModule>
@property (nonatomic, strong) id<IntroViewInput> view;

- (instancetype)initWithInteractor:(id<IntroInteractor>)interactor
                            router:(id<IntroRouter>)router;

@end
