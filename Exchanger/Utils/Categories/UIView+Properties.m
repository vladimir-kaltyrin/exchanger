#import "UIView+Properties.h"

@implementation UIView (Properties)
@dynamic size;
@dynamic origin;
@dynamic width;
@dynamic height;
@dynamic x;
@dynamic y;
@dynamic centerX;
@dynamic centerY;
@dynamic left;
@dynamic right;
@dynamic top;
@dynamic bottom;

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)x {
    return self.origin.x;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)y {
    return self.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    [self setX: centerX - self.width / 2];
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    [self setY:centerY - self.height / 2];
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setLeft:(CGFloat)left {
    [self setX: left];
}

- (CGFloat)left {
    return self.x;
}

- (void)setRight:(CGFloat)right {
    [self setX: right - self.width];
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setTop:(CGFloat)top {
    [self setY: top];
}

- (CGFloat)top {
    return self.y;
}

- (void)setBottom:(CGFloat)bottom {
    [self setY: bottom - self.height];
}

- (CGFloat)bottom {
    return self.top + self.height;
}

@end
