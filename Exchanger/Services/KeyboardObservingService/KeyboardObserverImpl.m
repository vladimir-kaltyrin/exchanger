#import <UIKit/UIKit.h>
#import "KeyboardObserverImpl.h"
#import "KeyboardData.h"

@interface KeyboardObserverImpl()
@property (nonatomic, strong) NSValue *keyboardFrameBegin;
@end

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
    
    if (self.keyboardFrameBegin != nil) {
        return;
    }
    
    NSDictionary *info = notification.userInfo;
    NSString *keyboardFrameBeginKey = UIKeyboardFrameEndUserInfoKey;
    self.keyboardFrameBegin = [info objectForKey:keyboardFrameBeginKey];
    
    KeyboardData *keyboardData = [[KeyboardData alloc] initWithSize:self.keyboardFrameBegin.CGRectValue.size];
    
    onKeyboardData(keyboardData);
}

@end
