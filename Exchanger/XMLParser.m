#import <XMLDictionary.h>
#import "XMLParser.h"

@interface XMLParser()
@property (nonatomic, strong) XMLDictionaryParser *parser;
@end

@implementation XMLParser {
    dispatch_queue_t _queue;
}

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
    _queue = dispatch_queue_create("com.exchanger.xmlParserQueue", 0);
}

// MARK: - IXMLParser

- (void)parse:(NSData *)data onComplete:(void (^)(NSDictionary *))onComplete
{
    dispatch_async(_queue, ^{
        NSDictionary *dictionary = [self.parser dictionaryWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            onComplete(dictionary);
        });
    });
}

@end
