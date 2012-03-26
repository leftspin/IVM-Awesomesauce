//
//  RootViewController.m
//  animationtest
//
//  Created by Mike Manzano on 3/23/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "RootViewController.h"
#import "NextViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASAnimatedTransition.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.title = @"Le Button View" ;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leButtonTapped:(id)sender 
	{
	NextViewController *nvc = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil] ;

	// This performs a flipboard-like animation
	ASAnimatedTransition *animatedTransition = [[ASAnimatedTransition alloc] init] ;
	animatedTransition.sourceView = self.view ;
	animatedTransition.destinationView = nvc.view ;
	animatedTransition.hostView = self.view ;
	animatedTransition.initializeAnimationBlock = ^(AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer)
		{
		CATransform3D transform = CATransform3DIdentity ;
		transform.m34 =  1.0 / -200 ;
		transform = CATransform3DTranslate(transform, 0, 5, -25) ;
		destinationLayer.transform = transform ;
		} ;
	animatedTransition.performAnimationBlock = ^(AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer)
		{
		[CATransaction setAnimationDuration:0.6] ;
		sourceLayer.position = CGPointMake(sourceLayer.position.x, -sourceLayer.frame.size.height/2.0) ;
		destinationLayer.transform = CATransform3DIdentity ;
		} ;
	animatedTransition.animationFinishedBlock = ^()
		{
		[self.navigationController pushViewController:nvc animated:NO] ;
		} ;
	[animatedTransition performTransition] ;
	}

@end
