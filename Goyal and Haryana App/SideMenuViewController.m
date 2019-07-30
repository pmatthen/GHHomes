//
//  SideBarViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 26/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "SWRevealViewController.h"
#import "MenuViewController.h"
#import "LatestNewsViewController.h"
#import "DisclaimerViewController.h"
#import "TellAFriendViewController.h"
#import "ContactUsViewController.h"

@interface SideMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SideMenuViewController {
    NSArray *menuItems;
    NSDictionary *notificationInfo;
    int screenHeight;
}
@synthesize followUsLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    notificationInfo = [NSDictionary new];
    notificationInfo = [NSDictionary dictionaryWithObject:@"MenuViewController" forKey:@"page"];
    
    // Pick up the page reference notification and trigger receivePageReference function
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView:)
                                                 name:@"activePage"
                                               object:nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:followUsLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, followUsLabel.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.0]
                             range:NSMakeRange(0, followUsLabel.text.length)];
    
    followUsLabel.attributedText = attributedString;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ) {
        [self.closeSideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    menuItems = @[@"Home", @"Latest News", @"Disclaimer", @"Tell A Friend", @"Contact Us"];
    
    FBSDKLikeControl *button = [[FBSDKLikeControl alloc] init];
    button.objectID = @"https://www.facebook.com/goyalco";
    button.likeControlStyle = FBSDKLikeControlStyleBoxCount;
    
    CGRect myFrame;
    switch (screenHeight) {
        case 480:
            myFrame = CGRectMake(84, 371, button.frame.size.width, button.frame.size.height);
            break;
        case 568:
            myFrame = CGRectMake(84, 447, button.frame.size.width, button.frame.size.height);
            break;
        case 667:
            myFrame = CGRectMake(84, 523, button.frame.size.width, button.frame.size.height);
            break;
        case 736:
            myFrame = CGRectMake(96, 576, button.frame.size.width, button.frame.size.height);
            break;
        default:
            myFrame = CGRectMake(84, 447, button.frame.size.width, button.frame.size.height);
            break;
    }
    
    [button setFrame:myFrame];
    [self.view addSubview:button];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) reloadTableView:(NSNotification *)notification {
    notificationInfo = notification.userInfo;
    [_myTableView reloadData];
}

- (void)receivePageReference:(NSNotification *)notification {
    for (int i = 0; i < [menuItems count]; i++) {
        
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[i] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        
        NSLog(@"Cell text is - %@", cell.myLabel.text);
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor greenColor]
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
    
    NSDictionary *notificationInfo = notification.userInfo;
    
    NSLog(@"The notificationInfo is %@", [notificationInfo objectForKey:@"page"]);
    
    if ([[notificationInfo objectForKey:@"page"] isEqualToString:@"MenuViewController"]){
        int row = 0;
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[row] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor greenColor]
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
    
    else if ([[notificationInfo objectForKey:@"page"] isEqualToString:@"LatestNewsViewController"]){
        int row = 1;
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[row] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor greenColor]
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
    
    else if ([[notificationInfo objectForKey:@"page"] isEqualToString:@"DisclaimerViewController"]){
        int row = 2;
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[row] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor greenColor]
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
    
    else if ([[notificationInfo objectForKey:@"page"] isEqualToString:@"TellAFriendViewController"]){
        int row = 3;
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[row] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor greenColor]
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
    
    else if ([[notificationInfo objectForKey:@"page"] isEqualToString:@"ContactUsViewController"]){
        int row = 4;
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[_myTableView dequeueReusableCellWithIdentifier:menuItems[row] forIndexPath:myIndexPath];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
        [attributedString addAttribute:NSKernAttributeName
                                 value:@(1.4)
                                 range:NSMakeRange(0, cell.myLabel.text.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor greenColor]
                       range:NSMakeRange(0, cell.myLabel.text.length)];
        
        cell.myLabel.attributedText = attributedString;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cell.myLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, cell.myLabel.text.length)];
    
    NSArray *viewControllers = @[@"MenuViewController", @"LatestNewsViewController", @"DisclaimerViewController", @"TellAFriendViewController", @"ContactUsViewController"];
    
    UIColor *textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.0];;
    
    if ([[notificationInfo objectForKey:@"page"] isEqualToString:viewControllers[indexPath.row]]) {
        textColor = [UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0];
    } else {
        textColor = [UIColor colorWithRed:0.30 green:0.30 blue:0.30 alpha:1.0];
    }
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textColor
                             range:NSMakeRange(0, cell.myLabel.text.length)];
    
    cell.myLabel.attributedText = attributedString;
    
    return cell;
}

- (IBAction)instagramButtonPressed:(id)sender {
    NSURL *instURL = [[NSURL alloc] initWithString:@"instagram://user?username=goyalco_hariyanagrp"];
    NSURL *instWB = [[NSURL alloc] initWithString:@"https://instagram.com/goyalco_hariyanagrp/"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instURL]) {
        [[UIApplication sharedApplication] openURL:instURL];
    } else {
        [[UIApplication sharedApplication] openURL:instWB];
    }
}

@end
