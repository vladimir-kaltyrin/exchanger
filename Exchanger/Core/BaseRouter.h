#import "BaseUIKitRouter.h"
#import "AssemblyFactory.h"

@interface BaseRouter : BaseUIKitRouter

@property (nonatomic, strong, readonly) id<AssemblyFactory> assemblyFactory;

- (instancetype)initWithAssemblyFactory:(id<AssemblyFactory>)assemblyFactory
                         viewController:(UIViewController *)viewController;

@end
