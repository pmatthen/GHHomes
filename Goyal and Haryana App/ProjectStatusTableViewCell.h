//
//  ProjectStatusTableViewCell.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 10/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectStatusTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *statusTitle;
@property (strong, nonatomic) IBOutlet UIView *emptyProgressBar;
@property (strong, nonatomic) IBOutlet UILabel *statusPercentComplete;

@end
