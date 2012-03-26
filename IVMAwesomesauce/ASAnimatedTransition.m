//
//  AnimatedTransition.m
//  animationtest
//
//  Created by Mike Manzano on 3/25/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "ASAnimatedTransition.h"
#import "UIView+Snapshot.h"
#import "AnimationView.h"

@implementation ASAnimatedTransition

#pragma mark - Properties
@synthesize sourceView, destinationView, animationFinishedBlock, performAnimationBlock, initializeAnimationBlock, hostView, backgroundColor ;

#pragma mark - Display

- (void) performTransition
	{
	NSAssert( self.sourceView, @"sourceView is nil" ) ;
	NSAssert( self.destinationView, @"destinationView is nil" ) ;
	NSAssert( self.hostView, @"hostView is nil" ) ;
	
	// Snapshot source and destination views
	UIImage *sourceImage = [self.sourceView snapshot] ;
	UIImage *destinationImage = [self.destinationView snapshot] ;
	
	// Create sublayers with the view image snapshots
	CALayer *sourceLayer = [CALayer layer] ;
	sourceLayer.contents = (id) sourceImage.CGImage ;
	CGFloat sourceNativeWidth = CGImageGetWidth(sourceImage.CGImage) / [UIScreen mainScreen].scale ;
	CGFloat sourceNativeHeight = CGImageGetHeight(sourceImage.CGImage) / [UIScreen mainScreen].scale ;
	sourceLayer.frame = CGRectMake(0, 0, sourceNativeWidth, sourceNativeHeight) ;
	
	CALayer *destinationLayer = [CALayer layer] ;
	destinationLayer.contents = (id) destinationImage.CGImage ;
	CGFloat destinationNativeWidth = CGImageGetWidth(destinationImage.CGImage) / [UIScreen mainScreen].scale ;
	CGFloat destinationNativeHeight = CGImageGetHeight(destinationImage.CGImage) / [UIScreen mainScreen].scale ;
	destinationLayer.frame = CGRectMake(0, 0, destinationNativeWidth, destinationNativeHeight) ;
	
	// Create the view in which the layer animation occurs
	AnimationView *animationView = [[AnimationView alloc] initWithFrame:hostView.bounds] ;
	animationView.backgroundColor = self.backgroundColor ? self.backgroundColor : [UIColor blackColor] ;
	
	// Add the layers to the animationView
	[animationView.layer addSublayer:destinationLayer] ;
	[animationView.layer addSublayer:sourceLayer] ;
	
	// Initialize the animations
	if( self.initializeAnimationBlock )
		self.initializeAnimationBlock( animationView, sourceLayer, destinationLayer ) ;
	
	// Assign the animation to the animation view. Wrap a CATransaction around it
	if( self.performAnimationBlock )
		{
		__block AnimationView *blockAnimationView = animationView ;
		animationView.animationBlock = ^()
			{
			[CATransaction begin] ;
			[CATransaction setCompletionBlock:^{
				if( self.animationFinishedBlock )
					self.animationFinishedBlock() ;
				[blockAnimationView removeFromSuperview] ;
			}] ;
			
			if( self.performAnimationBlock )
				self.performAnimationBlock( blockAnimationView, sourceLayer, destinationLayer ) ;
			
			[CATransaction commit] ;
			} ; // animationBlock
		} // perform animation
		
	// Add the animation view to the host layer, which will execute the animation once it becomes part of the view hierarchy
	[self.hostView addSubview:animationView] ;
	}
@end
