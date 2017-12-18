#import "XMLDictionary.h"
#import "XMLParserImpl.h"

@interface XMLParserImpl()
@property (nonatomic, strong) XMLDictionaryParser *parser;
@end

@implementation XMLParserImpl

// MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reset];
    }
    
    return self;
}

// MARK: - State

- (void)reset
{
    self.parser = [[XMLDictionaryParser alloc] init];
}

// MARK: - IXMLParser

- (void)parse:(NSData *)data onComplete:(void (^)(NSDictionary *))onComplete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dictionary = [self.parser dictionaryWithData:data];
        onComplete(dictionary);
    });
}

@end
