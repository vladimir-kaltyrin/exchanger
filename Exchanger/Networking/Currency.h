#import <Foundation/Foundation.h>
#import "CurrencyType.h"

@interface Currency : NSObject
@property (nonatomic, assign) CurrencyType currencyType;
@property (nonatomic, strong) NSNumber *rate;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray<Currency *> *)arrayOfObjects: (NSArray<NSDictionary *> *)arrayOfDictionaries;

@end
