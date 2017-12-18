#import "CarouselPageIndicator.h"
#import "UIView+Properties.h"

@interface CarouselPageIndicator ()
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation CarouselPageIndicator

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:frame];
        self.pageControl.tintColor = [UIColor whiteColor];
        self.pageControl.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.pageControl];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage ofTotal:(NSInteger)total {
    self.pageControl.numberOfPages = total;
    self.pageControl.currentPage = currentPage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.width = self.bounds.size.width;
    self.pageControl.height = 24;
    self.pageControl.bottom = self.bottom;
}

@end
