#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GalleryPreviewPageData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewData : NSObject
    
@property (nonatomic, strong, readonly) NSArray<GalleryPreviewPageData *> *pages;
@property (nonatomic, strong, readonly) void(^onTap)();
    
- (instancetype)initWithPages:(NSArray<GalleryPreviewPageData *> *)pages onTap:(void(^)())onTap;
    
@end

NS_ASSUME_NONNULL_END
