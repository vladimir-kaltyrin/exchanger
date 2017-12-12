#import <Foundation/Foundation.h>

@interface FormatterResultData : NSObject
@property (nonatomic, strong) NSAttributedString *formattedString;
@property (nonatomic, strong) NSString *string;

- (instancetype)initWithFormattedString:(NSAttributedString *)formattedString string:(NSString *)balance;

@end
