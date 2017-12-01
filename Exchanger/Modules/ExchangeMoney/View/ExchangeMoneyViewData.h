#import <Foundation/Foundation.h>

@class GalleryPreviewData;
@class User;
@class ExchangeRatesData;

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeMoneyViewData : NSObject

@property (nonatomic, strong, readonly) GalleryPreviewData *sourceData;
@property (nonatomic, strong, readonly) GalleryPreviewData *targetData;

- (instancetype)initWithSourceData:(GalleryPreviewData *)sourceData
                        targetData:(GalleryPreviewData *)targetData;

- (instancetype)initWithUser:(User *)user
                 sourceRates:(ExchangeRatesData *)sourceRates
                 targetRates:(ExchangeRatesData *)targetRates;

@end

NS_ASSUME_NONNULL_END
