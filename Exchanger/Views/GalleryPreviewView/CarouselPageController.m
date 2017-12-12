#import "CarouselPageController.h"
#import "CarouselPage.h"
#import "CarouselController.h"
#import "UIView+Debug.h"
#import "SafeBlocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarouselPageController ()
@property (nonatomic, strong) CarouselPage *pageView;
@end

NS_ASSUME_NONNULL_END

@implementation CarouselPageController

- (instancetype)initWithIndex:(NSInteger)index data:(CarouselPageData *)data {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _index = index;
        
        self.pageView = [[CarouselPage alloc] initWithFrame:CGRectZero];
        [self.pageView setViewData:data];
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    block(self.onPageWillChange);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.checkCanFocus != nil) {
        if (self.checkCanFocus()) {
            [self.pageView focus];
        }
    }
    
    block(self.onViewDidAppear);
}

- (void)focus {
    [self.pageView focus];
}

- (void)setOnFocus:(void (^)())onFocus {
    [self.pageView setOnFocus:onFocus];
}
    
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    NSAssert(NO, @"initWithNibName:bundle has not been implemented");
    return nil;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    NSAssert(NO, @"initWithCoder has not been implemented");
    return nil;
}

- (instancetype)init {
    NSAssert(NO, @"init has not been implemented");
    return nil;
}
    
- (void)prepareForReuse {
    [self.pageView prepareForReuse];
}
    
- (void)loadView {
    self.view = self.pageView;
}

@end
