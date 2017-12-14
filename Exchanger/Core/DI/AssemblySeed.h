#import <Foundation/Foundation.h>
#import "ServiceFactory.h"
#import "AssemblyFactory.h"

@interface AssemblySeed : NSObject
@property (nonatomic, strong) id<AssemblyFactory> assemblyFactory;
@property (nonatomic, strong) id<ServiceFactory> serviceFactory;
@end
