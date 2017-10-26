#import <UIKit/UIKit.h>

@class GalleryPreviewData;

typedef NS_ENUM(NSInteger, CurrencyRateCellStyle) {
    CurrencyRateCellStyleLight,
    CurrencyRateCellStyleDark
};

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyRateCell : UITableViewCell

- (void)updateWithModel:(GalleryPreviewData *)model;

- (instancetype)initWithStyle:(CurrencyRateCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
    
@end

NS_ASSUME_NONNULL_END
