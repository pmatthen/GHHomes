//
//  ProjectViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 20/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>

@interface ProjectViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSString *projectName;
@property (strong, nonatomic) PFObject *projectObject;

@property (strong, nonatomic) IBOutlet UIButton *largerSideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *blockPhotoShareButton;

@property (strong, nonatomic) IBOutlet UIButton *blockSelectionButton;
@property (strong, nonatomic) IBOutlet UILabel *blockSelectionButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *projectInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *projectStatusButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *facebookLabel;
@property (strong, nonatomic) IBOutlet UILabel *messengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *whatsappLabel;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)blockSelectionButtonPressed:(id)sender;
- (IBAction)projectInfoButtonPressed:(id)sender;
- (IBAction)projectStatusButtonPressed:(id)sender;
- (IBAction)locationButtonPressed:(id)sender;
- (IBAction)blockPhotoShareButtonPressed:(id)sender;
- (IBAction)mailShareButtonPressed:(id)sender;
- (IBAction)facebookShareButtonPressed:(id)sender;
- (IBAction)messengerShareButtonPressed:(id)sender;
- (IBAction)whatsappShareButtonPressed:(id)sender;

@end
