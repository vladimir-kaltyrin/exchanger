//
//  TextField.m
//  Exchanger
//
//  Created by Калтырин Владимир on 11.12.17.
//  Copyright © 2017 Vladimir Kaltyrin. All rights reserved.
//

#import "TextField.h"

@implementation TextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)becomeFirstResponder {
    NSLog(@"%@", self.window);
    
    BOOL result = [super becomeFirstResponder];
    
    return result;
}

- (BOOL)canBecomeFirstResponder {
    BOOL result = [super canBecomeFirstResponder];
    
    return result;
}

- (BOOL)resignFirstResponder {
    
    return [super resignFirstResponder];
}

@end
