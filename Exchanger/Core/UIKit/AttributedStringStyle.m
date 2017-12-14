#import "AttributedStringStyle.h"

@implementation AttributedStringStyle

- (NSDictionary<NSAttributedStringKey,id> *)attributes {
    
    NSMutableDictionary<NSAttributedStringKey,id> *result = [NSMutableDictionary dictionary];
    
    if (self.foregroundColor != nil) {
        result[NSForegroundColorAttributeName] = self.foregroundColor;
    }
    
    if (self.font != nil) {
        result[NSFontAttributeName] = self.font;
    }
    
    NSParagraphStyle *paragraphStyle = [self paragraphStyle];
    if (paragraphStyle != nil) {
        result[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    
    return result;
}

// MARK: - Private

- (NSParagraphStyle *)paragraphStyle {
    
    BOOL somethingIsSet = NO;
    
    NSMutableParagraphStyle *result = [[NSMutableParagraphStyle alloc] init];
    
    if (self.textAlignment > 0) {
        result.alignment = self.textAlignment;
        somethingIsSet = YES;
    }
    
    if (self.lineBreakMode > 0) {
        result.lineBreakMode = self.lineBreakMode;
        somethingIsSet = YES;
    }
    
    if (somethingIsSet) {
        return result;
    }
    
    return nil;
}

@end
