//
//  AnimationView.m
//  easybook
//
//  Created by Mike Manzano on 4/27/11.
//  Copyright 2011 IVM. All rights reserved.
//
//	Unlimited license granted to Counterless, Inc.

#import "AnimationView.h"
#import <QuartzCore/QuartzCore.h>


@implementation AnimationView

#pragma mark - Properties

@synthesize animationBlock = animationBlock_ ;


#pragma mark - Instance

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
	{
	self.animationBlock = nil ;
	}

#pragma mark - UIView

- (void) startAnimation
	{
	self.animationBlock() ;
	}

- (void)didMoveToSuperview
	{
	if( self.superview )
		if( self.animationBlock )
			[self performSelector:@selector(startAnimation) withObject:nil afterDelay:0] ;
	}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
