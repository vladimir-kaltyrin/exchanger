#import <UIKit/UIGestureRecognizerSubclass.h>
#import "MoveFailableLongPressGestureRecognizer.h"

@interface MoveFailableLongPressGestureRecognizer()
@property (nonatomic, assign) CGPoint initialPoint;
@end

@implementation MoveFailableLongPressGestureRecognizer
    
- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if (self = [super initWithTarget:target action:action]) {
        self.initialPoint = CGPointZero;
        self.allowableMovementAfterBegan = CGFLOAT_MAX;
    }
    return self;
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.initialPoint = [self locationInView: self.view];
}
    
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (self.allowableMovementAfterBegan != CGFLOAT_MAX) {
        CGPoint currentPoint = [self locationInView: self.view];
        CGFloat movement = hypot(self.initialPoint.x - currentPoint.x, self.initialPoint.y - currentPoint.y);
        
        if (movement > self.allowableMovementAfterBegan) {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)reset {
    [super reset];
    self.initialPoint = CGPointZero;
}

@end
