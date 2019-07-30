//
//  ProjectStatusTableViewCell.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 10/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "ProjectStatusTableViewCell.h"

@implementation ProjectStatusTableViewCell
@synthesize emptyProgressBar;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    emptyProgressBar.layer.cornerRadius = 3;
    emptyProgressBar.layer.masksToBounds = YES;
    [emptyProgressBar setBackgroundColor:[UIColor colorWithRed:0.04 green:0.15 blue:0.27 alpha:1.0]];
}

@end
