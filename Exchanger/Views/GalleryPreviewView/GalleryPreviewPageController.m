#import "GalleryPreviewPageController.h"
#import "GalleryPreviewPage.h"
#import "GalleryPreviewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageController ()
@property (nonatomic, strong) GalleryPreviewPage *pageView;
@end

NS_ASSUME_NONNULL_END

@implementation GalleryPreviewPageController

- (instancetype)initWithIndex:(NSInteger)index data:(GalleryPreviewPageData *)data {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _index = index;
        
        self.pageView = [[GalleryPreviewPage alloc] initWithFrame:CGRectZero];
        [self.pageView setViewData:data];
        
    }
    return self;
}
    
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    NSAssert(NO, @"initWithNibName:bundle has not been implemented");
    return nil;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    NSAssert(NO, @"initWithCoder has not been implemented");
    return nil;
}
    
- (void)prepareForReuse {
    [self.pageView prepareForReuse];
}
    
- (void)loadView {
    self.view = self.pageView;
}

@end
