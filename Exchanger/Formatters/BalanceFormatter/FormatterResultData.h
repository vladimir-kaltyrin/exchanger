#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BalanceFormatterSign) {
    BalanceFormatterSignMinus,
    BalanceFormatterSignPlus,
    BalanceFormatterSignNone
};

@interface FormatterResultData : NSObject
@property (nonatomic, strong) NSAttributedString *formattedString;
@property (nonatomic, strong) NSString *string;

- (instancetype)initWithFormattedString:(NSAttributedString *)formattedString string:(NSString *)balance;

- (float)floatValue;

+ (FormatterResultData *)formatterDataWithString:(NSString *)string;

+ (FormatterResultData *)formatterDataWithString:(NSString *)string sign:(BalanceFormatterSign)sign;

+ (FormatterResultData *)formatterDataWithNumber:(NSNumber *)number sign:(BalanceFormatterSign)sign;

@end
