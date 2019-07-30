//
//  ProjectInfoViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 09/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProjectInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet NSString *projectName;
@property (strong, nonatomic) IBOutlet PFObject *projectObject;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *projectInfoImage;

- (IBAction)backButtonPressed:(id)sender;

@end
