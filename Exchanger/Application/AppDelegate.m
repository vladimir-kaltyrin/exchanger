#import "AppDelegate.h"
#import "AssemblyFactory.h"
#import "AssemblyFactoryImpl.h"

@interface AppDelegate ()
@property (nonatomic, strong) id<AssemblyFactory> assemblyFactory;
@property (nonatomic, strong) AssembledViewController *rootModule;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.assemblyFactory = [[AssemblyFactoryImpl alloc] init];
    
    id<IntroAssembly> rootAssembly = [[self assemblyFactory] introAssembly];
    self.rootModule = [rootAssembly module];
    
    [self makeWindowKeyAndVisibleWith:self.rootModule.viewController];
    
    return YES;
}

- (void)makeWindowKeyAndVisibleWith:(UIViewController *)rootViewController {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [_window makeKeyAndVisible];
}

@end
