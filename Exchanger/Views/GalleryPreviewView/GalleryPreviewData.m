#import "GalleryPreviewData.h"

@implementation GalleryPreviewData
    
- (instancetype)initWithPages:(NSArray<GalleryPreviewPageData *> *)pages
                  currentPage:(NSInteger)currentPage
                        onTap:(void(^)())onTap
{
    if (self = [super init]) {
        _pages = pages;
        _currentPage = currentPage;
        _onTap = onTap;
    }
    return self;
}

@end
