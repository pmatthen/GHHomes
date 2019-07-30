//
//  SideBarViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 26/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface SideMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *closeSideMenuButton;
@property (strong, nonatomic) IBOutlet UILabel *followUsLabel;

- (IBAction)instagramButtonPressed:(id)sender;

@end
