//
//  UIView+ResignFirstResponder.h
//
//  Created by Mike Manzano on 7/29/11.
//  http://creativecommons.org/licenses/by-sa/3.0/ via http://stackoverflow.com/questions/1823317/how-do-i-legally-get-the-current-first-responder-on-the-screen-on-an-iphone

#import <UIKit/UIKit.h>

// This category resigns whoever the first responder happens to be. This is useful in forms to force all text fields to commit editing before validating them or whatever
@interface UIView (ResignFirstResponder)
- (UIView *)findFirstResponder ;
- (void) tellFirstResponderToResign ;
@end
