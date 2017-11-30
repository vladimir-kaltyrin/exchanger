#import "AssemblyFactoryImpl.h"
#import "ExchangeMoneyAssemblyImpl.h"
#import "IntroAssemblyImpl.h"
#import "AssemblySeed.h"
#import "ServiceFactoryImpl.h"
#import "AssemblyFactory.h"

@implementation AssemblyFactoryImpl

- (id<ExchangeMoneyAssembly>)exchangeMoneyAssembly {
    return [[ExchangeMoneyAssemblyImpl alloc] initWithAssemblySeed:[self assemblySeed]];
}

- (id<IntroAssembly>)introAssembly {
    return [[IntroAssemblyImpl alloc] initWithAssemblySeed:[self assemblySeed]];
}

// MARK: - Private

- (AssemblySeed *)assemblySeed {
    AssemblySeed *result = [[AssemblySeed alloc] init];
    result.serviceFactory = [[ServiceFactoryImpl alloc] init];
    result.assemblyFactory = [[AssemblyFactoryImpl alloc] init];
    return result;
}

@end
