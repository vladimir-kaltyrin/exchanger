#import "Currency.h"
#import "CurrencyFormatter.h"

@implementation Currency

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        @try {
            self.currencyType = [CurrencyFormatter currencyTypeFromString:[dictionary objectForKey:@"_currency"]];
            self.rate = @([[dictionary objectForKey:@"_rate"] floatValue]);
        } @catch (NSException *exception) {
            NSLog(@"Wrong data.");
            self.currencyType = CurrencyTypeNotFound;
            self.rate = @0;
        }
    }
    return self;
}

- (NSString *)currencyCode {
    return [CurrencyFormatter toCodeString:self.currencyType];
}

- (NSString *)currencySign {
    return [CurrencyFormatter toSignString:self.currencyType];
}

+ (NSArray<Currency *> *)arrayOfObjects:(NSArray<NSDictionary *> *)arrayOfDictionaries {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dictionary in arrayOfDictionaries) {
        Currency *currency = [[Currency alloc] initWithDictionary:dictionary];
        [result addObject:currency];
    }
    return result;
}

@end
