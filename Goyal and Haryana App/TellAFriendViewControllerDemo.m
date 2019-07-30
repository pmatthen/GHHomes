//
//  TellAFriendViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 24/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "TellAFriendViewControllerDemo.h"
#import <MessageUI/MessageUI.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface TellAFriendViewControllerDemo () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation TellAFriendViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLikeControl *button = [[FBSDKLikeControl alloc] init];
    button.objectID = @"https://www.facebook.com/goyalco";
    [button setFrame:CGRectMake(127, 227, button.frame.size.width, button.frame.size.height)];
    NSLog(@"The width and height of the Facebook Like button is %f and %f", button.frame.size.width, button.frame.size.height);
    [self.view addSubview:button];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.goyalco.com/"];
    content.contentTitle = @"GoyalCo and Haryana Group Website";
    content.imageURL = [NSURL URLWithString:@"https://yt3.ggpht.com/-VhNc_tY9p0M/AAAAAAAAAAI/AAAAAAAAAAA/zOPVh9hotwA/s900-c-k-no-rj-c0xffffff/photo.jpg"];
    content.contentDescription = @"Just a test description";
    
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    [shareButton setFrame:CGRectMake(127, 305, shareButton.frame.size.width, shareButton.frame.size.height)];
    [self.view addSubview:shareButton];
    
    FBSDKSendButton *sendButton = [[FBSDKSendButton alloc] init];
    sendButton.shareContent = content;
    [sendButton setFrame:CGRectMake(127, 373, sendButton.frame.size.width, sendButton.frame.size.height)];
    [self.view addSubview:sendButton];
}

- (IBAction)emailButtonPressed:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"GoyalCo and Haryana Group make great homes!!";
    // To address
    // NSArray *toRecipents = [NSArray arrayWithObject:@"poulosem@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    // [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
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

- (IBAction)sMSButtonPressed:(id)sender {
    [self showSMS:@"http://www.goyalco.com/"];
}

- (void)showSMS:(NSString*)file {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    // NSArray *recipents = @[@"12345678", @"72345524"];
    NSString *message = [NSString stringWithFormat:@"Check this out %@! Also, GoyalCo and Haryana Group make great homes!!", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    // [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)messageThroughFacebookMessengerButtonPressed:(id)sender {
}

- (IBAction)backButtonPressed:(id)sender {
    NSLog(@"backButtonPressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
