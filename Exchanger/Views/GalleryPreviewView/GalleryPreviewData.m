#import "GalleryPreviewData.h"

@implementation GalleryPreviewData
    
- (instancetype)initWithPages:(NSArray<GalleryPreviewPageData *> *)pages onTap:(void(^)())onTap {
    if (self = [super init]) {
        _pages = pages;
        _onTap = onTap;
    }
    return self;
}

@end
