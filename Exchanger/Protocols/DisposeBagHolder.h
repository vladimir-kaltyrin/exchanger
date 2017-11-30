#import "DisposeBag.h"

@protocol DisposeBagHolder
- (void)addDisposable:(id)disposable;
@end
