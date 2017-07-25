#import <UIKit/UIKit.h>
#import "KeyboardObservingServiceImpl.h"

@implementation KeyboardObservingServiceImpl
@synthesize onKeyboardSize;

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShown:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// MARK: - Notifications

- (void)keyboardWillShown:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSString *keyboardFrameBeginKey = UIKeyboardFrameBeginUserInfoKey;
    NSValue *keyboardFrameBegin = [info objectForKey:keyboardFrameBeginKey];
    onKeyboardSize(keyboardFrameBegin.CGRectValue.size);
}

@end
