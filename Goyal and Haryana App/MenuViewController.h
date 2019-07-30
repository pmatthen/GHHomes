//
//  MenuViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 18/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *largerSideMenuButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
