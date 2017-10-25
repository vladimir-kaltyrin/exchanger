#import "GalleryPreviewPageData.h"

@implementation GalleryPreviewPageData
    
- (instancetype)initWithPlaceholder:(UIImage *)placeholder imageUrl:(NSString *)imageUrl {
    if (self = [super init]) {
        _placeholder = placeholder;
        _imageUrl = imageUrl;
    }
    return self;
}

@end
