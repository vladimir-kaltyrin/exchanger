#import "BaseRouter.h"

@interface BaseRouter()
@property (nonatomic, strong) id<AssemblyFactory> assemblyFactory;
@end

@implementation BaseRouter

- (instancetype)initWithAssemblyFactory:(id<AssemblyFactory>)assemblyFactory
                         viewController:(UIViewController *)viewController {
    self = [super initWithViewController:viewController];
    if (self) {
        self.assemblyFactory = assemblyFactory;
    }
    return self;
}

@end
