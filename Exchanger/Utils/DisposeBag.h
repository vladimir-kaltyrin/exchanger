#import <Foundation/Foundation.h>

@interface DisposeBag : NSObject
- (void)addDisposable:(id)disposable;
@end
