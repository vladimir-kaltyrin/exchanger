#import <Foundation/Foundation.h>
#import "AssemblyFactory.h"
#import "AssemblySeed.h"
#import "ServiceFactory.h"

@interface BaseAssembly : NSObject
@property (nonatomic, strong) id<AssemblyFactory> assemblyFactory;
@property (nonatomic, strong) id<ServiceFactory> serviceFactory;

- (instancetype)initWithAssemblySeed:(AssemblySeed *)assemblySeed;

@end
