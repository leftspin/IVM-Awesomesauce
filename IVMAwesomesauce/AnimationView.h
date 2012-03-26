//
//  AnimationView.h
//  easybook
//
//  Created by Mike Manzano on 4/27/11.
//  Copyright 2011 IVM. All rights reserved.
//
//	Unlimited license granted to Counterless, Inc.

#import <UIKit/UIKit.h>

// A view that plays an animation block right after being added to
// a parent view. This view will not automatically remove itself,
// your animation block should do it.
@interface AnimationView : UIView 
	{
	void (^animationBlock_)(void) ;
	}

@property(copy,nonatomic) void (^animationBlock)(void) ;

@end
