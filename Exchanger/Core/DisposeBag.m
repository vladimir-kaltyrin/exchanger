#import "DisposeBag.h"

@interface DisposeBag()
@property (nonatomic, strong) NSArray *disposables;
@end

@implementation DisposeBag

- (instancetype)init {
    self = [super init];
    if (self) {
        self.disposables = [NSArray array];
    }
    return self;
}

- (void)addDisposable:(id)disposable{
    self.disposables = [self.disposables arrayByAddingObject:disposable];
}

@end
