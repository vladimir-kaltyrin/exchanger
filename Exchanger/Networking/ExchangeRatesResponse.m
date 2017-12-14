#import "ConvenientObjC.h"
#import "ExchangeRatesResponse.h"
#import "Currency.h"

@interface ExchangeRatesResponse()
@property (nonatomic, strong) NSArray<Currency *> *currencies;
@end

@implementation ExchangeRatesResponse

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        @try {
            NSArray *cubes = [self parse:dictionary];
            self.currencies = [Currency arrayOfObjects:cubes];
        } @catch (NSException *exception) {
            NSLog(@"Wrong data.");
            self.currencies = [NSArray array];
        }
    }
    return self;
}

- (NSArray *)parse: (NSDictionary *)sourceDictionary {
    var nextNode = sourceDictionary;
    while ([nextNode.allKeys indexOfObject:@"Cube"] != NSNotFound) {
        nextNode = [nextNode objectForKey:@"Cube"];
        if ([nextNode isKindOfClass:[NSArray class]]) {
            return (NSArray *)nextNode;
        }
    }
    return nil;
}

@end
