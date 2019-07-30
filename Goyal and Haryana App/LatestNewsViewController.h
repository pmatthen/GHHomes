//
//  LatestNewsViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>

@interface LatestNewsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *largerSideMenuButton;
@property (strong, nonatomic) IBOutlet UIView *navigationBarView;
@property (strong, nonatomic) IBOutlet UIButton *newsButton;
@property (strong, nonatomic) IBOutlet UIButton *offersButton;
@property (strong, nonatomic) IBOutlet UIView *newsSelectedView;
@property (strong, nonatomic) IBOutlet UIView *offersSelectedView;
@property (strong, nonatomic) IBOutlet UITableView *newsTableView;
@property (strong, nonatomic) IBOutlet UITableView *offersTableView;
@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *facebookLabel;
@property (strong, nonatomic) IBOutlet UILabel *messengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *whatsappLabel;

- (IBAction)newsButtonPressed:(id)sender;
- (IBAction)offersButtonPressed:(id)sender;
- (IBAction)mailShareButtonPressed:(id)sender;
- (IBAction)facebookShareButtonPressed:(id)sender;
- (IBAction)messengerShareButtonPressed:(id)sender;
- (IBAction)whatsappShareButtonPressed:(id)sender;

@end
