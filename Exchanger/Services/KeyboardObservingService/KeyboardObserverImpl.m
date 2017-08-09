#import <UIKit/UIKit.h>
#import "KeyboardObserverImpl.h"
#import "KeyboardData.h"

@implementation KeyboardObserverImpl
@synthesize onKeyboardData;

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
    
    KeyboardData *keyboardData = [[KeyboardData alloc] initWithSize:keyboardFrameBegin.CGRectValue.size];
    
    onKeyboardData(keyboardData);
}

@end
