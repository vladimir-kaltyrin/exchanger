#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ParsingResult) {
    ParsingResultZero,
    ParsingResultInteger,
    ParsingResultFloat
};

@interface BalanceParseData : NSObject
@property (nonatomic, assign) ParsingResult parsingResult;
@property (nonatomic, strong) NSArray<NSString *> *components;
@property (nonatomic, strong) NSString *formattedString;
@end
