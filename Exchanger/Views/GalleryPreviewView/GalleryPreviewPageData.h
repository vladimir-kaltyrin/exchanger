#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ObservableTextField.h"

typedef NS_ENUM(NSInteger, GalleryPreviewPageRemainderStyle) {
    GalleryPreviewPageRemainderStyleNormal,
    GalleryPreviewPageRemainderStyleDeficiency
};

NS_ASSUME_NONNULL_BEGIN

@interface GalleryPreviewPageData : NSObject

@property (nonatomic, strong, readonly) NSString *currencyTitle;
@property (nonatomic, strong, readonly) NSString *input;
@property (nonatomic, strong, readonly) NSString *remainder;
@property (nonatomic, strong, readonly) NSString *rate;
@property (nonatomic, assign, readonly) GalleryPreviewPageRemainderStyle remainderStyle;
@property (nonatomic, strong, readonly) TextFieldAttributedStringFormatter inputFormatter;
@property (nonatomic, strong, readonly) OnTextChange onTextChange;
    
- (instancetype)initWithCurrencyTitle:(NSString *)currencyTitle
                                input:(NSString *)input
                            remainder:(NSString *)remainder
                                 rate:(NSString *)rate
                       remainderStyle:(GalleryPreviewPageRemainderStyle)remainderStyle
                       inputFormatter:(TextFieldAttributedStringFormatter)inputFormatter
                         onTextChange:(OnTextChange)onTextChange;
    
@end

NS_ASSUME_NONNULL_END
