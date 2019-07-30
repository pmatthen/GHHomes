//
//  DisclaimerViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "SWRevealViewController.h"

@interface DisclaimerViewController ()

@property int screenHeight;

@end

@implementation DisclaimerViewController
@synthesize sideMenuButton, titleLabel, screenHeight;

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
}

-(void)viewWillAppear:(BOOL)animated {
    // Send notification containing page reference to be picked up by sidebar view controller
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"DisclaimerViewController" forKey:@"page"];
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

@end
