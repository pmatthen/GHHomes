//
//  SignUpViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 18/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "SignUpViewController.h"
#import "MenuViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize emailTextField, passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)signUpButtonPressed:(id)sender {
    if (([emailTextField.text length] > 0) && ([passwordTextField.text length] > 0)) {
        PFUser *user = [PFUser user];
        
        user.username = [emailTextField.text lowercaseString];
        user.password = passwordTextField.text;
        user.email = [emailTextField.text lowercaseString];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Continue with Code.
            } else {
                if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:ok];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            
            [PFUser logInWithUsernameInBackground:[emailTextField.text lowercaseString] password:passwordTextField.text block:^(PFUser *user, NSError *error) {
                if (!error) {
                    if (user) {
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        MenuViewController *myMenuViewController = [MenuViewController new];
                        myMenuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
                        
                        CATransition *transition = [CATransition animation];
                        transition.duration = 0.3;
                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                        transition.type = kCATransitionPush;
                        transition.subtype = kCATransitionFromRight;
                        [self.view.window.layer addAnimation:transition forKey:nil];
                        
                        [self presentModalViewController:myMenuViewController animated:NO];
                    } else {
                        if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alert show];
                        }
                        else {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                            [alertController addAction:ok];
                            
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                    }
                } else {
                    if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                    }
                    else {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:ok];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }
            }];
        }];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
