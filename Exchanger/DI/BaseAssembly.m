#import "BaseAssembly.h"
#import "AssemblySeed.h"

@implementation BaseAssembly

- (instancetype)initWithAssemblySeed:(AssemblySeed *)assemblySeed {
    self = [super init];
    if (self) {
        self.assemblyFactory = assemblySeed.assemblyFactory;
        self.serviceFactory = assemblySeed.serviceFactory;
    }
    
    return self;
}

@end
