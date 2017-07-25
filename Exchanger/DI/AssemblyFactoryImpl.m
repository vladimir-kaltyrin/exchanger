#import "AssemblyFactoryImpl.h"
#import "ExchangeMoneyAssemblyImpl.h"
#import "AssemblySeed.h"
#import "ServiceFactory.h"
#import "AssemblyFactory.h"

@implementation AssemblyFactoryImpl

- (id<ExchangeMoneyAssembly>)exchangeMoneyAssembly {
    return [[ExchangeMoneyAssemblyImpl alloc] initWithAssemblySeed:[self assemblySeed]];
}

// MARK: - Private

- (AssemblySeed *)assemblySeed {
    AssemblySeed *result = [[AssemblySeed alloc] init];
    result.serviceFactory = [[ServiceFactory alloc] init];
    result.assemblyFactory = [[AssemblyFactoryImpl alloc] init];
    return result;
}

@end
