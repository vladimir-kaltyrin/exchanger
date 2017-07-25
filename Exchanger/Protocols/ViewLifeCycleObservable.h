#import <Foundation/Foundation.h>

@protocol ViewLifeCycleObservable <NSObject>

@property (nonatomic, strong) void(^onViewDidLoad)();

@property (nonatomic, strong) void(^onViewWillAppear)();

@property (nonatomic, strong) void(^onViewDidAppear)();

@property (nonatomic, strong) void(^onViewWillDisappear)();

@property (nonatomic, strong) void(^onViewDidDisappear)();

@end
