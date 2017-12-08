#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GalleryPreviewPageData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewData : NSObject
    
@property (nonatomic, strong, readonly) NSArray<GalleryPreviewPageData *> *pages;
@property (nonatomic, strong, readonly, nullable) void(^onTap)();
@property (nonatomic, assign, readonly) NSInteger currentPage;
    
- (instancetype)initWithPages:(NSArray<GalleryPreviewPageData *> *)pages
                  currentPage:(NSInteger)currentPage
                        onTap:(void(^)())onTap;
    
@end

NS_ASSUME_NONNULL_END
