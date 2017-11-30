#import <UIKit/UIKit.h>
#import "ViewLifeCycleObservable.h"
#import "DisposeBagHolder.h"

@interface BaseViewController : UIViewController<ViewLifeCycleObservable, DisposeBagHolder>
@end
