//
//  ViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 18/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "LandingPageViewController.h"
#import <Parse/Parse.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MenuViewController.h"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController
@synthesize signUpButton, signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self noSignInRequiredCode];
}

- (void)noSignInRequiredCode {
    [signUpButton setHidden:TRUE];
    [signInButton setHidden:TRUE];
    
    [self performSelector:@selector(segueToMenuPage) withObject:nil afterDelay:2.0];
}

- (void) segueToMenuPage {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    MenuViewController *myMenuViewController = [MenuViewController new];
    myMenuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
}

- (void)addFacebookLoginButton {
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (IBAction)signUpButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
}

- (IBAction)signInButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SignInSegue" sender:self];
}

@end
