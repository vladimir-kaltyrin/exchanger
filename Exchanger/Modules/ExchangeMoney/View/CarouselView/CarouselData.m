#import "CarouselData.h"

@implementation CarouselData
    
- (instancetype)initWithPages:(NSArray<CarouselPageData *> *)pages
                  currentPage:(NSInteger)currentPage
{
    if (self = [super init]) {
        _pages = pages;
        _currentPage = currentPage;
    }
    return self;
}

@end
