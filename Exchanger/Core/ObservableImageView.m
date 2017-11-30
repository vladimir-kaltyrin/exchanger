#import "ObservableImageView.h"
#import "SafeBlocks.h"

static void * Context = &Context;

@implementation ObservableImageView
    
// MARK: - Init

- (instancetype)init {
    if (self = [super init]) {
        [self setupObserver];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupObserver];
    }
    return self;
}
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupObserver];
    }
    return self;
}
    
- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self setupObserver];
    }
    return self;
}
    
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        [self setupObserver];
    }
    return self;
}
    
- (void)dealloc {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(setImage:))];
}
    
- (void)setupObserver {
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(setImage:))
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:Context];
}
    
// MARK: - Observer
    
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (context == Context) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(setImage:))]) {
            UIImage *newImage = [change objectForKey:NSKeyValueChangeNewKey];
            block(_onImageChange, newImage)
        }
    }
}

@end
