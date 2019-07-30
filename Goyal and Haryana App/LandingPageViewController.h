//
//  ViewController.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 18/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingPageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIButton *signInButton;

- (IBAction)signUpButtonPressed:(id)sender;
- (IBAction)signInButtonPressed:(id)sender;

@end

