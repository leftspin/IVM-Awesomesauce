//
//  UIView+ResignFirstResponder.m
//
//  Created by Mike Manzano on 7/29/11.
//  http://creativecommons.org/licenses/by-sa/3.0/ via http://stackoverflow.com/questions/1823317/how-do-i-legally-get-the-current-first-responder-on-the-screen-on-an-iphone

#import "UIView+ResignFirstResponder.h"

@implementation UIView (ResignFirstResponder)

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {        
        return self;     
    }
	
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
		
        if (firstResponder != nil) {
			return firstResponder;
        }
    }
	
    return nil;
}

- (void) tellFirstResponderToResign
	{
	[[self findFirstResponder] resignFirstResponder] ;
	}
@end
