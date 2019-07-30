//
//  TellAFriendViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 03/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface TellAFriendViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *largerSideMenuButton;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *facebookLabel;
@property (strong, nonatomic) IBOutlet UILabel *messengerLabel;
@property (strong, nonatomic) IBOutlet UILabel *whatsappLabel;

- (IBAction)mailButtonPressed:(id)sender;
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)messengerButtonPressed:(id)sender;
- (IBAction)whatsappButtonPressed:(id)sender;

@end
