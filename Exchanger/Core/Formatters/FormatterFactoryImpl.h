#import <Foundation/Foundation.h>
#import "FormatterFactory.h"

@interface FormatterFactoryImpl : NSObject<FormatterFactory>

+ (instancetype)instance;

@end
