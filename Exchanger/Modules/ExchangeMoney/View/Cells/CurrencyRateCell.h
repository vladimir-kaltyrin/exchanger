#import <UIKit/UIKit.h>

@class GalleryPreviewData;

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyRateCell : UITableViewCell

- (void)updateWithModel:(GalleryPreviewData *)model;
    
@end

NS_ASSUME_NONNULL_END
