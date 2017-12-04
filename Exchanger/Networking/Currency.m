#import "Currency.h"
#import "FormatterFactoryImpl.h"

@interface Currency()
@property (nonatomic, strong) id<CurrencyFormatter> currencyFormatter;
@end

@implementation Currency

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.currencyFormatter = [[FormatterFactoryImpl instance] currencyFormatter];
        @try {
            self.currencyType = [self.currencyFormatter currencyTypeFromString:[dictionary objectForKey:@"_currency"]];
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
    return [self.currencyFormatter toCodeString:self.currencyType];
}

- (NSString *)currencySign {
    return [self.currencyFormatter toSignString:self.currencyType];
}

+ (NSArray<Currency *> *)arrayOfObjects:(NSArray<NSDictionary *> *)arrayOfDictionaries {
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *dictionary in arrayOfDictionaries) {
        Currency *currency = [[Currency alloc] initWithDictionary:dictionary];
        [result addObject:currency];
    }
    return result;
}

+ (Currency *)currencyWithType:(CurrencyType)currencyType {
    Currency *currency = [[Currency alloc] init];
    currency.currencyType = currencyType;
    
    return currency;
}

@end
