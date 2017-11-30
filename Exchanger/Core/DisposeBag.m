#import "DisposeBag.h"

@interface DisposeBag()
@property (nonatomic, strong) NSMutableArray *disposables;
@end

@implementation DisposeBag

- (instancetype)init {
    self = [super init];
    if (self) {
        self.disposables = [NSMutableArray array];
    }
    return self;
}

- (void)addDisposable:(id)disposable{
    [self.disposables addObject:disposable];
}

@end
