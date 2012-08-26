//
//  KnockoffTableViewController.h
//  IVMAwesomesauce
//
//  Created by Mike Manzano on 7/31/11.
//  Copyright 2011 IVM. All rights reserved.
//
// See: http://cocoawithlove.com/2009/03/recreating-uitableviewcontroller-to.html
//
// Portions of this code are:
//
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  1.2: Changed keyboard calculations to use tableview instead of view for field focusing
//	1.3: Added self.doNotAutoscrollToFirstResponder
//	1.4: Before it only scrolled a field into view if the keyboard wasn't up yet. Now it always does so.

#import <UIKit/UIKit.h>


// This is a table view controller that basically does the same thing as UITableViewController only we have full control over the dimensions and manipulation of the table view. For example, UITableViewController insists on making its table view full screen and any amount of mucking around with it makes it angry. And you wouldn't like it when it's angry. This class lets us do whatever we want while UITableViewController sulks in the corner.
@interface KnockoffTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
	{
	UITableView *tableView_ ;
	}

@property( nonatomic, strong ) IBOutlet UITableView *tableView ;
@property( nonatomic, assign ) BOOL doNotAutoscrollToFirstResponder ; // bypass autoscrolling to active field when keyboard is shown

// Perhaps this should be a in a category of UITableView
	+ (void) scrollActiveFieldToVisibleWithKeyboardHeight: (CGFloat) keyboardHeight tableView: (UITableView *) tableView containingView: (UIView *) containingView ;
	
- (id)initWithStyle:(UITableViewStyle)style ;
@end
