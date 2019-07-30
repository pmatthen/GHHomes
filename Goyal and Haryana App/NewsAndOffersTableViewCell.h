//
//  NewsAndOffersTableViewCell.h
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 11/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsAndOffersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *posterProfilePicImageView;
@property (strong, nonatomic) IBOutlet UILabel *posterNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *postButtonImage;
@property (strong, nonatomic) IBOutlet UITextView *postTextView;

@end
