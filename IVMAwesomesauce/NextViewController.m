//
//  NextViewController.m
//  animationtest
//
//  Created by Mike Manzano on 3/23/12.
//  Copyright (c) 2012 Instant Voodoo Magic. All rights reserved.
//

#import "NextViewController.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>

@interface NextViewController ()

@end

@implementation NextViewController

@synthesize headerLabelText ;

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
	self.title = @"Le Knob View" ;
	
	// Header view
	NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] ;
	HeaderView *headerView = [nibObjects objectAtIndex:0] ;
	NSAssert1( [headerView isKindOfClass:[HeaderView class]] , @"headerView isn't a HeaderView but a %@" , [headerView class] ) ;
	
	[self.view addSubview:headerView] ;
//	headerView.headerLabel.text = self.headerLabelText ;
	headerView.layer.shadowOffset = CGSizeMake(0, 1) ;
	headerView.layer.shadowColor = [UIColor blackColor].CGColor ;
	headerView.layer.shadowOpacity = 1.0 ;
	headerView.layer.shadowRadius = 3 ;
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

- (IBAction)knobButtonTapped:(id)sender {
	[self.navigationController popViewControllerAnimated:YES] ;
}

@end
