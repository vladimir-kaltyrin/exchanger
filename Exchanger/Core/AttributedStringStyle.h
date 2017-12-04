#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AttributedStringStyle : NSObject
@property (nonatomic, strong, nullable) UIColor *foregroundColor;
@property (nonatomic, strong, nullable) UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;

- (NSDictionary<NSAttributedStringKey,id> * _Nonnull)attributes;

@end
