#import <UIKit/UIKit.h>
#import "CurrencyExchangeType.h"

@class GalleryPreviewData;

typedef NS_ENUM(NSInteger, CurrencyRateCellStyle) {
    CurrencyRateCellStyleLight,
    CurrencyRateCellStyleDark
};

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyRateCell : UITableViewCell

- (void)updateWithModel:(GalleryPreviewData *)model;

- (void)setOnPageChange:(void(^)(NSInteger current))onPageChange;

- (void)setCurrencyExchangeType:(CurrencyExchangeType)currencyExchangeType;

- (instancetype)initWithStyle:(CurrencyRateCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
    
@end

NS_ASSUME_NONNULL_END
