#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AssembledViewController : NSObject
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) id module;

- (instancetype)initWithViewController:(UIViewController *)viewController
                                module:(id)module;

@end
