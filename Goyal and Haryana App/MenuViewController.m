//
//  MenuViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 18/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewTableViewCell.h"
#import "ProjectViewController.h"
#import "TellAFriendViewControllerDemo.h"
#import "SWRevealViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *projectsArray;
@property int currentTableViewRow;
@property int screenHeight;

@end

@implementation MenuViewController
@synthesize myTableView, sideMenuButton, titleLabel, largerSideMenuButton, projectsArray, currentTableViewRow, screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController ) {
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
    
    projectsArray = [NSMutableArray new];
    currentTableViewRow = 0;
    
    PFQuery *query = [PFQuery queryWithClassName:@"ProjectIndex"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [projectsArray addObjectsFromArray:objects];
            [myTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self checkToSeeIfLoggedIntoParse:FALSE];
    
    // Send notification containing page reference to be picked up by sidebar view controller
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"MenuViewController" forKey:@"page"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"activePage" object:nil userInfo:userInfo];
}

-(void) checkToSeeIfLoggedIntoParse:(BOOL)isChecking {
    if (isChecking) {
        if (![PFUser currentUser]) {
            UINavigationController *myInitialNavigationController = [UINavigationController new];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            myInitialNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
            
            [self presentViewController:myInitialNavigationController animated:YES completion:nil];
        } else {
            //
        }
    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [projectsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewTableViewCell *cell = (MenuViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
    
    PFObject *tempProjectObject = projectsArray[indexPath.row];
    
//    if ([tempProjectObject[@"projectName"] uppercaseString].length == 0) {
//        return cell;
//    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[tempProjectObject[@"projectName"] uppercaseString]];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, [tempProjectObject[@"projectName"] uppercaseString].length)];
    
    cell.titleLabel.attributedText = attributedString;
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:tempProjectObject[@"shortDescription"]];
    [attributedString2 addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, [tempProjectObject[@"shortDescription"] length])];
    
    cell.descriptionLabel.attributedText = attributedString2;
    
    PFFile *projectImageFile = tempProjectObject[@"mainImage"];
    [projectImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.myImageView.image = [UIImage imageWithData:imageData];
        }
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentTableViewRow = (int) indexPath.row;
    [self performSegueWithIdentifier:@"ProjectSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProjectSegue"]) {
        ProjectViewController *myProjectViewController = (ProjectViewController *) segue.destinationViewController;
        
        PFObject *tempProjectObject = projectsArray[currentTableViewRow];
        
        myProjectViewController.projectName = tempProjectObject[@"projectName"];
        myProjectViewController.projectObject = tempProjectObject;
    }
}

@end
