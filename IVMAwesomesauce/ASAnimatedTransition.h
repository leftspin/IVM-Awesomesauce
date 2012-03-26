//
//  AnimatedTransition.h
//  animationtest
//
//  Created by Mike Manzano on 3/25/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationView.h"
#import <QuartzCore/QuartzCore.h>

// Block definitions
typedef void (^AnimationFinishedBlock)(void) ;
typedef void (^PerformAnimationBlock)( AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer ) ;
typedef void (^InitializeAnimationBlock)( AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer ) ;

// A class to perform a custom animated transition between two views. Specifically, this class snapshots both source and destination views and provides them as layers to your animation blocks. It automatically handles adding and removing these layers to a host view in which the animation will occur that you supply. This class should be used to animate a transition from one view to another and is not really usable for general animation like animating a view along a path, or animating frames.
@interface ASAnimatedTransition : NSObject
@property( nonatomic, strong ) UIView *sourceView ; // the view to animate from
@property( nonatomic, strong ) UIView *destinationView ; // the view which replaces sourceView
@property( nonatomic, strong ) UIView *hostView ; // the view in which animations occur
@property( nonatomic, copy ) AnimationFinishedBlock animationFinishedBlock ; // the block to perform when the animation finishes
@property( nonatomic, copy ) InitializeAnimationBlock initializeAnimationBlock ; // the black to peform before the animation starts. This block performs outside of any CATransaction
@property( nonatomic, copy ) PerformAnimationBlock performAnimationBlock ; // the block that actually starts off the animation. This block is wrapped with a CATransaction begin/end, and has its completion block set to animationFinishedBlock
@property( nonatomic, strong ) UIColor *backgroundColor ; // the color to display behind the animation. Defaults to black.
- (void) performTransition ;
@end
