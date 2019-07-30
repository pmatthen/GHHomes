//
//  ProjectStatusViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 09/08/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "ProjectStatusViewController.h"
#import "ProjectStatusTableViewCell.h"

@interface ProjectStatusViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *projectStatusTitleArray;
@property (nonatomic, strong) NSArray *projectStatusValuesArray;
@property int screenHeight;

@end

@implementation ProjectStatusViewController
@synthesize titleLabel, projectStatusImage, projectNameLabel, detailLabel, blockObject, projectObject, myTableView, projectStatusTitleArray, projectStatusValuesArray, screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    PFFile *projectImageFile = projectObject[@"projectInfoImage"];
    [projectImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            projectStatusImage.image = [UIImage imageWithData:imageData];
        } else {
            NSLog(@"Error = %@", error.localizedDescription);
        }
    }];

    
    projectStatusTitleArray = [NSArray new];
    projectStatusValuesArray = [NSArray new];
    
    projectStatusTitleArray = @[@"Footing", @"Plinth Beam", @"Retaining Wall", @"Floor Slabs", @"Block Work", @"Internal Plastering", @"PVC Plumbing", @"CPVC Plumbing", @"Electrical", @"Waterproofing", @"Bathroom Tiling", @"Painting Putty", @"Balcony Railing", @"Balcony Filling", @"External Plastering", @"Floor Tiles"];
    
    if (!blockObject[@"projectStatus_Footing"]) {
        blockObject[@"projectStatus_Footing"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_PlinthBeam"]) {
        blockObject[@"projectStatus_PlinthBeam"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_RetainingWall"]) {
        blockObject[@"projectStatus_RetainingWall"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_FloorSlabs"]) {
        blockObject[@"projectStatus_FloorSlabs"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_BlockWork"]) {
        blockObject[@"projectStatus_BlockWork"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_InternalPlastering"]) {
        blockObject[@"projectStatus_InternalPlastering"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_PVCPlumbing"]) {
        blockObject[@"projectStatus_PVCPlumbing"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_CPVCPlumbing"]) {
        blockObject[@"projectStatus_CPVCPlumbing"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_Electrical"]) {
        blockObject[@"projectStatus_Electrical"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_Waterproofing"]) {
        blockObject[@"projectStatus_Waterproofing"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_BathroomTiling"]) {
        blockObject[@"projectStatus_BathroomTiling"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_PaintingPutty"]) {
        blockObject[@"projectStatus_PaintingPutty"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_BalconyRailing"]) {
        blockObject[@"projectStatus_BalconyRailing"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_BalconyFilling"]) {
        blockObject[@"projectStatus_BalconyFilling"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_ExternalPlastering"]) {
        blockObject[@"projectStatus_ExternalPlastering"] = [NSNumber numberWithInt:0];
    }
    if (!blockObject[@"projectStatus_FloorTiles"]) {
        blockObject[@"projectStatus_FloorTiles"] = [NSNumber numberWithInt:0];
    }
    
    if (blockObject) {
        projectStatusValuesArray = @[blockObject[@"projectStatus_Footing"], blockObject[@"projectStatus_PlinthBeam"], blockObject[@"projectStatus_RetainingWall"], blockObject[@"projectStatus_FloorSlabs"], blockObject[@"projectStatus_BlockWork"], blockObject[@"projectStatus_InternalPlastering"], blockObject[@"projectStatus_PVCPlumbing"], blockObject[@"projectStatus_CPVCPlumbing"], blockObject[@"projectStatus_Electrical"], blockObject[@"projectStatus_Waterproofing"], blockObject[@"projectStatus_BathroomTiling"], blockObject[@"projectStatus_PaintingPutty"], blockObject[@"projectStatus_BalconyRailing"], blockObject[@"projectStatus_BalconyFilling"], blockObject[@"projectStatus_ExternalPlastering"], blockObject[@"projectStatus_FloorTiles"]];
    } else {
        projectStatusValuesArray = @[@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0];
    }
    
    [myTableView reloadData];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, titleLabel.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, titleLabel.text.length)];
    
    titleLabel.attributedText = attributedString;
    if (blockObject) {
        [detailLabel setText:blockObject[@"blockName"]];
        projectNameLabel.text = [blockObject[@"projectName"] uppercaseString];
    } else {
        [detailLabel setText:@""];
        projectNameLabel.text = @"";
    }
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:projectNameLabel.text];
    [attributedString2 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, projectNameLabel.text.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                              range:NSMakeRange(0, projectNameLabel.text.length)];
    
    projectNameLabel.attributedText = attributedString2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [projectStatusTitleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = projectStatusTitleArray[indexPath.row];
    ProjectStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.statusTitle.text = projectStatusTitleArray[indexPath.row];
    
    NSNumber *progressBarProgress = projectStatusValuesArray[indexPath.row];
    float progressBarWidth = cell.emptyProgressBar.frame.size.width * ([progressBarProgress floatValue]/100);
    
    UIView *progressBar = [[UIView alloc] init];
    progressBar.tag = 9;
    [progressBar setBackgroundColor:[UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0]];
    progressBar.layer.cornerRadius = 3;
    progressBar.layer.masksToBounds = YES;
    [progressBar setFrame:CGRectMake(cell.emptyProgressBar.frame.origin.x, cell.emptyProgressBar.frame.origin.y, progressBarWidth, cell.emptyProgressBar.frame.size.height)];
    
    [cell addSubview:progressBar];
    
    cell.statusPercentComplete.text = [NSString stringWithFormat:@"%@%%", progressBarProgress];
    
    return cell;
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
