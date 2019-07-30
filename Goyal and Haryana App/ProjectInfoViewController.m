//
//  ProjectInfoViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 09/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "ProjectInfoViewController.h"

@interface ProjectInfoViewController ()

@property int screenHeight;

@end

@implementation ProjectInfoViewController
@synthesize titleLabel, projectNameLabel, projectInfoImage, projectName, projectObject, screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, titleLabel.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, titleLabel.text.length)];
    
    titleLabel.attributedText = attributedString;
    
    projectNameLabel.text = [projectName uppercaseString];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:projectNameLabel.text];
    [attributedString2 addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, projectNameLabel.text.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, projectNameLabel.text.length)];
    
    projectNameLabel.attributedText = attributedString2;
    
    CGRect labelFrame;
    
    switch (screenHeight) {
        case 480:
            labelFrame = CGRectMake(40, 254, 240, 197);
            break;
        case 568:
            labelFrame = CGRectMake(40, 300, 240, 233);
            break;
        case 667:
            labelFrame = CGRectMake(40, 351, 295, 273);
            break;
        case 736:
            labelFrame = CGRectMake(45, 386, 324, 300);
            break;
        default:
            labelFrame = CGRectMake(40, 300, 240, 233);
            break;
    }
    
    float fontSize;
    
    switch (screenHeight) {
        case 480:
            fontSize = 13.0;
            break;
        case 568:
            fontSize = 13.0;
            break;
        case 667:
            fontSize = 15.0;
            break;
        case 736:
            fontSize = 17.0;
            break;
        default:
            fontSize = 13.0;
            break;
    }
    
    PFFile *projectImageFile = projectObject[@"projectInfoImage"];
    [projectImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            projectInfoImage.image = [UIImage imageWithData:imageData];
        } else {
            NSLog(@"Error = %@", error.localizedDescription);
        }
    }];
    
    UILabel *projectInfoLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [projectInfoLabel setText:projectObject[@"projectInformation"]];
    [projectInfoLabel setNumberOfLines:0];
    [projectInfoLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:fontSize]];
    [projectInfoLabel sizeToFit];
    
    [self.view addSubview:projectInfoLabel];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
