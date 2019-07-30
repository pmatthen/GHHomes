//
//  WebsiteViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/10/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIButton *goBackButton;
@property (strong, nonatomic) IBOutlet UIButton *goForwardButton;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)goBackButtonPressed:(id)sender;
- (IBAction)goForwardButtonPressed:(id)sender;

@end
