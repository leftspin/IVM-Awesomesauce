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
#import "HeaderView.h"

@interface RootViewController ()
@end

@implementation RootViewController
	{
	CGRect headerViewFrame_ ;
	IBOutlet UIButton *autoTransitionButton_;
	IBOutlet UIScrollView *scrollView_;
	}

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
	self.title = @"Le Cover View" ;
	
	// Set up the scroll view
	CGRect contentFrame = scrollView_.bounds ;
	contentFrame.size.width *= 3 ; // 3 pages to scroll through
	scrollView_.contentSize = contentFrame.size ;
	
	NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil] ;
	NSArray *labels = [NSArray arrayWithObjects:@"The Beat", @"Fuku Burger", @"Slidin' Through", nil] ;
	for( int x = 0 ; x < 3; x++ ) 
		{
		CGRect viewFrame = scrollView_.bounds ;
		viewFrame.origin.x = x * viewFrame.size.width ;
		UIView *coverView = [[UIView alloc] initWithFrame:viewFrame] ;
		coverView.backgroundColor = [colors objectAtIndex:x] ;
		[scrollView_ addSubview:coverView] ;

		// Gestures
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leButtonTapped:)] ;
		[coverView addGestureRecognizer:tap] ;

		// Header view (actually a footer in this view)
#define HEADER_VIEW_TAG 0xbeef
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] ;
		HeaderView *headerView = [nibObjects objectAtIndex:0] ;
		NSAssert1( [headerView isKindOfClass:[HeaderView class]] , @"headerView isn't a HeaderView but a %@" , [headerView class] ) ;
		
		CGRect newFrame = headerView.frame ;
		newFrame.origin.y = self.view.bounds.size.height - headerView.frame.size.height ;
		headerView.frame = newFrame ;

		headerView.tag = HEADER_VIEW_TAG ;
		headerView.headerLabel.text = [labels objectAtIndex:x] ;
		headerView.layer.shadowOffset = CGSizeMake(0, 1) ;
		headerView.layer.shadowColor = [UIColor blackColor].CGColor ;
		headerView.layer.shadowOpacity = 1.0 ;
		headerView.layer.shadowRadius = 3 ;

		[coverView addSubview:headerView] ;
		
		headerViewFrame_ = headerView.frame ; // any of these will do they're all the same
		}
	}

- (void)viewDidUnload
{
	autoTransitionButton_ = nil;
	scrollView_ = nil;
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
		transform.m34 =  1.0 / -200 ; // perspective
		transform = CATransform3DTranslate(transform, 0, 5, -25) ;
		destinationLayer.transform = transform ;
		} ;
	animatedTransition.performAnimationBlock = ^(AnimationView *animationView, CALayer *sourceLayer, CALayer *destinationLayer)
		{
		[CATransaction setAnimationDuration:0.6] ;
		sourceLayer.position = CGPointMake(sourceLayer.position.x, (-sourceLayer.frame.size.height/2.0) + headerViewFrame_.size.height) ;
		destinationLayer.transform = CATransform3DIdentity ;
		} ;
	animatedTransition.animationFinishedBlock = ^()
		{
		[self.navigationController pushViewController:nvc animated:NO] ;
		} ;
	[animatedTransition performTransition] ;
	}

@end
