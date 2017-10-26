#import "ExchangeMoneyViewData.h"
#import "User.h"
#import "ExchangeRatesData.h"
#import "Currency.h"

@implementation ExchangeMoneyViewData

- (instancetype)initWithSourceData:(GalleryPreviewData *)sourceData targetData:(GalleryPreviewData *)targetData {
    if (self = [super init]) {
        _sourceData = sourceData;
        _targetData = targetData;
    }
    return self;
}

- (instancetype)initWithUser:(User *)user sourceRates:(ExchangeRatesData *)sourceRates targetRates:(ExchangeRatesData *)targetRates {
    if (self = [super init]) {
        
    }
    return self;
}

@end
