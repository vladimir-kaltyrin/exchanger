#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BalanceFormatterSign) {
    BalanceFormatterSignMinus,
    BalanceFormatterSignPlus,
    BalanceFormatterSignNone
};

@interface FormatterData : NSObject
@property (nonatomic, strong) NSAttributedString *formattedString;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSNumber *number;

- (instancetype)initWithFormattedString:(NSAttributedString *)formattedString
                                 string:(NSString *)balance
                                 number:(NSNumber *)number;

- (float)floatValue;

+ (FormatterData *)formatterDataWithString:(NSString *)string;

+ (FormatterData *)formatterDataWithString:(NSString *)string sign:(BalanceFormatterSign)sign;

+ (FormatterData *)formatterDataWithNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign;

@end
