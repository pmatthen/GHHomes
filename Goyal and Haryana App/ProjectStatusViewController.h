//
//  ProjectStatusViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 09/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProjectStatusViewController : UIViewController

@property (strong, nonatomic) IBOutlet PFObject *blockObject;
@property (strong, nonatomic) IBOutlet PFObject *projectObject;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *projectStatusImage;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)backButtonPressed:(id)sender;

@end
