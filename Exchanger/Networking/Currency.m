#import "Currency.h"
#import "FormatterFactoryImpl.h"

@interface Currency()
@property (nonatomic, strong) id<CurrencyFormatter> currencyFormatter;
@end

@implementation Currency

// MARK: - Init

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setup];
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

// MARK: - Private

- (void)setup {
    self.currencyFormatter = [[FormatterFactoryImpl instance] currencyFormatter];
}

// MARK: - Public

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
