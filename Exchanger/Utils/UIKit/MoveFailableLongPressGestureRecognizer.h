#import <UIKit/UIKit.h>

/// Against UILongPressGestureRecognizer can fail on move after transition to began state
@interface MoveFailableLongPressGestureRecognizer : UILongPressGestureRecognizer
@property (nonatomic, assign) CGFloat allowableMovementAfterBegan;
@end
