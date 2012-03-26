//
//  UIView+Snapshot.m
//  animationtest
//
//  Created by Mike Manzano on 3/25/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "UIView+Snapshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Snapshot)
- (UIImage *) snapshot ;
	{
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image ;
	}
@end
