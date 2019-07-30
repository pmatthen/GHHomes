//
//  ContactUsViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SWRevealViewController.h"

@interface ContactUsViewController () <MFMailComposeViewControllerDelegate>

@property int screenHeight;

@end

@implementation ContactUsViewController
@synthesize sideMenuButton, largerSideMenuButton, titleLabel, sendFeedBackLabel, screenHeight, websiteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ) {
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
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:sendFeedBackLabel.text];
    [attributedString2 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, sendFeedBackLabel.text.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                              range:NSMakeRange(0, sendFeedBackLabel.text.length)];
    
    sendFeedBackLabel.attributedText = attributedString2;
    
    [websiteButton setTitleColor:[UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated {
    // Send notification containing page reference to be picked up by sidebar view controller
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"ContactUsViewController" forKey:@"page"];
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

- (IBAction)phoneButtonPressed:(id)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:@"+918088833000"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)mailButtonPressed:(id)sender {
    // Email Subject
    NSString *emailTitle = @"";
    // Email Content
    NSString *messageBody = @"";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"mkt.bng@goyalco.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    NSLog(@"Can I Send Mail? ---> %s", [MFMailComposeViewController canSendMail] ? "true" : "false");
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    } else {
        
    }
}

- (IBAction)websiteButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"WebsiteSegue" sender:nil];
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

@end
