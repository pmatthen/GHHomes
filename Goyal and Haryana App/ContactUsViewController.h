//
//  ContactUsViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactUsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *largerSideMenuButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sendFeedBackLabel;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;

- (IBAction)phoneButtonPressed:(id)sender;
- (IBAction)mailButtonPressed:(id)sender;
- (IBAction)websiteButtonPressed:(id)sender;

@end
