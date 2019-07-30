//
//  TellAFriendViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 03/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "TellAFriendViewController.h"
#import "SWRevealViewController.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface TellAFriendViewController () <MFMailComposeViewControllerDelegate>

@property(nonatomic, strong) FBSDKShareButton *shareButton;
@property(nonatomic, strong) FBSDKSendButton *sendButton;
@property int screenHeight;

@end

@implementation TellAFriendViewController
@synthesize sideMenuButton, titleLabel, mailLabel, facebookLabel, messengerLabel, whatsappLabel, shareButton, sendButton, screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.largerSideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.revealViewController.delegate = self;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, titleLabel.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, titleLabel.text.length)];
    
    titleLabel.attributedText = attributedString;
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:mailLabel.text];
    [attributedString2 addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, mailLabel.text.length)];
    
    mailLabel.attributedText = attributedString2;
    
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:facebookLabel.text];
    [attributedString3 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, facebookLabel.text.length)];
    
    facebookLabel.attributedText = attributedString3;
    
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:messengerLabel.text];
    [attributedString4 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, messengerLabel.text.length)];
    
    messengerLabel.attributedText = attributedString4;
    
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:whatsappLabel.text];
    [attributedString5 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, whatsappLabel.text.length)];
    
    whatsappLabel.attributedText = attributedString5;
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://itunes.apple.com/app/id1156911994"];
    content.contentTitle = @"Goyal Co | Hariyana Group App";
    content.imageURL = [NSURL URLWithString:@"https://yt3.ggpht.com/-VhNc_tY9p0M/AAAAAAAAAAI/AAAAAAAAAAA/zOPVh9hotwA/s900-c-k-no-rj-c0xffffff/photo.jpg"];
    content.contentDescription = @"See information about Goyal Co | Hariyana Group's upcoming properties";
    
    shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    [shareButton setFrame:CGRectMake(127, 305, shareButton.frame.size.width, shareButton.frame.size.height)];
    [self.view addSubview:shareButton];
    [shareButton setHidden:TRUE];
    
    sendButton = [[FBSDKSendButton alloc] init];
    sendButton.shareContent = content;
    [sendButton setFrame:CGRectMake(127, 373, sendButton.frame.size.width, sendButton.frame.size.height)];
    [self.view addSubview:sendButton];
    [sendButton setHidden:TRUE];
}

-(void)viewWillAppear:(BOOL)animated {
    // Send notification containing page reference to be picked up by sidebar view controller
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"TellAFriendViewController" forKey:@"page"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"activePage" object:nil userInfo:userInfo];
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)mailButtonPressed:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Check out the new GH Homes App";
    // Email Content
    NSString *messageBody = @"I thought you might be interested in the Goyal & Co | Hariyana Group mobile app. It provides information on their upcoming properties - http://itunes.apple.com/app/id1156911994 ,Cheers!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (IBAction)facebookButtonPressed:(id)sender {
    [shareButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)messengerButtonPressed:(id)sender {
    [sendButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)whatsappButtonPressed:(id)sender {
    NSString *textToShare = @"See information about Goyal Co | Hariyana Group's upcoming properties with their new app - http://itunes.apple.com/app/id1156911994";
    
    NSArray *objectsToShare = @[textToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
