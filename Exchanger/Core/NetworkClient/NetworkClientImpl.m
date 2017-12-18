#import "NetworkClientImpl.h"
#import "ServiceFactory.h"

static NSString *const kApiUrl = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@interface NetworkClientImpl()
@property (nonatomic, strong) id<XMLParser> parser;
@end

@implementation NetworkClientImpl

- (instancetype)initWithParser:(id<XMLParser>)parser {
    if (self = [super init]) {
        self.parser = parser;
    }
    return self;
}

@end
