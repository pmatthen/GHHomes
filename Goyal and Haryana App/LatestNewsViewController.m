//
//  LatestNewsViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "LatestNewsViewController.h"
#import "SWRevealViewController.h"
#import "NewsAndOffersTableViewCell.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface LatestNewsViewController () <UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSMutableArray *offersArray;
@property (nonatomic, strong) NSMutableArray *newsImagesArray;
@property (nonatomic, strong) NSMutableArray *offerImagesArray;
@property BOOL isSharingNews;
@property int sharingIndex;
@property(nonatomic, strong) FBSDKShareButton *shareButton;
@property(nonatomic, strong) FBSDKSendButton *sendButton;
@property (retain) UIDocumentInteractionController *documentInteractionController;
@property int screenHeight;

@end

@implementation LatestNewsViewController
@synthesize titleLabel, sideMenuButton, largerSideMenuButton, navigationBarView, newsButton, offersButton, newsSelectedView, offersSelectedView, newsTableView, offersTableView, newsArray, offersArray, shareView, shareLabel, mailLabel, facebookLabel, messengerLabel, whatsappLabel, newsImagesArray, offerImagesArray, isSharingNews, sharingIndex, shareButton, sendButton, documentInteractionController, screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    newsArray = [NSMutableArray new];
    offersArray = [NSMutableArray new];
    newsImagesArray = [NSMutableArray new];
    offerImagesArray = [NSMutableArray new];
    isSharingNews = TRUE;
    sharingIndex = 0;

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.largerSideMenuButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.revealViewController.delegate = self;
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeShareView:)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:letterTapRecognizer];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, titleLabel.text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, titleLabel.text.length)];
    
    titleLabel.attributedText = attributedString;
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:newsButton.titleLabel.text];
    [attributedString2 addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, newsButton.titleLabel.text.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, newsButton.titleLabel.text.length)];
    
    newsButton.titleLabel.attributedText = attributedString2;
    
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:offersButton.titleLabel.text];
    [attributedString3 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, offersButton.titleLabel.text.length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                              range:NSMakeRange(0, offersButton.titleLabel.text.length)];
    
    newsButton.titleLabel.attributedText = attributedString3;
    
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:shareLabel.text];
    [attributedString4 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, shareLabel.text.length)];
    
    shareLabel.attributedText = attributedString4;
    
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:mailLabel.text];
    [attributedString5 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, mailLabel.text.length)];
    
    mailLabel.attributedText = attributedString5;
    
    NSMutableAttributedString *attributedString6 = [[NSMutableAttributedString alloc] initWithString:facebookLabel.text];
    [attributedString6 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, facebookLabel.text.length)];
    
    facebookLabel.attributedText = attributedString6;
    
    NSMutableAttributedString *attributedString7 = [[NSMutableAttributedString alloc] initWithString:messengerLabel.text];
    [attributedString7 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, messengerLabel.text.length)];
    
    messengerLabel.attributedText = attributedString7;
    
    NSMutableAttributedString *attributedString8 = [[NSMutableAttributedString alloc] initWithString:whatsappLabel.text];
    [attributedString8 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, whatsappLabel.text.length)];
    
    whatsappLabel.attributedText = attributedString8;
    
    shareView.layer.cornerRadius = 2;
    shareView.layer.masksToBounds = YES;
    
    [navigationBarView setBackgroundColor:[UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0]];
    [offersSelectedView setHidden:TRUE];
    [offersTableView setHidden:TRUE];
    
    PFQuery *query = [PFQuery queryWithClassName:@"NewsAndOffers"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i < [objects count]; i++) {
                PFObject *tempNewsAndOfferObject = objects[i];
                if (tempNewsAndOfferObject[@"isOffer"] == [NSNumber numberWithBool:TRUE]) {
                    [offersArray addObject:tempNewsAndOfferObject];
                } else {
                    [newsArray addObject:tempNewsAndOfferObject];
                }
            }
            [newsTableView reloadData];
            [offersTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    shareButton = [[FBSDKShareButton alloc] init];
    [self.view addSubview:shareButton];
    [shareButton setHidden:TRUE];
    
    sendButton = [[FBSDKSendButton alloc] init];
    [self.view addSubview:sendButton];
    [sendButton setHidden:TRUE];
}

-(void)viewWillAppear:(BOOL)animated {
    // Send notification containing page reference to be picked up by sidebar view controller
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"LatestNewsViewController" forKey:@"page"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"activePage" object:nil userInfo:userInfo];
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
    if (tableView == newsTableView) {
        return [newsArray count];
    } else {
        return [offersArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == newsTableView) {
        NewsAndOffersTableViewCell *cell = (NewsAndOffersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsAndOffersCell"];
        
        cell.shareButton.tag = indexPath.row;
        [cell.shareButton addTarget:self action:@selector(newsShareButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [cell.postButtonImage addTarget:self action:@selector(newsPostImageButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        PFObject *tempNewsObject = newsArray[indexPath.row];
        
        PFFile *posterImageFile = tempNewsObject[@"posterThumbnailImage"];
        [posterImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                cell.posterProfilePicImageView.image = [UIImage imageWithData:imageData];
            }
        }];
        
        PFFile *messageImageFile = tempNewsObject[@"messageImage"];
        [messageImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                [cell.postButtonImage setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                [newsImagesArray setObject:[UIImage imageWithData:imageData] atIndexedSubscript:indexPath.row];
            }
        }];
        
        cell.posterNameLabel.text = tempNewsObject[@"poster"];
        cell.postTextView.text = tempNewsObject[@"message"];
        
        NSDate *createdAtDate = tempNewsObject.createdAt;
        NSCalendar *gregorianCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [gregorianCalender components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:createdAtDate toDate:[NSDate date] options:0];
        
        if ([dateComponents year] > 0) {
            if ([dateComponents year] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld year ago", [dateComponents year]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld years ago", [dateComponents year]];
            }
        } else if ([dateComponents month] > 0) {
            if ([dateComponents month] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld month ago", [dateComponents month]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld months ago", [dateComponents month]];
            }
        } else if ([dateComponents day] > 0) {
            if ([dateComponents day] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld day ago", [dateComponents day]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld days ago", [dateComponents day]];
            }
        } else if ([dateComponents hour] > 0) {
            if ([dateComponents hour] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld hour ago", [dateComponents hour]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld hours ago", [dateComponents hour]];
            }
        } else if ([dateComponents minute] > 0) {
            if ([dateComponents minute] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld minute ago", [dateComponents minute]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld minutes ago", [dateComponents minute]];
            }
        } else if ([dateComponents second] > 0) {
            if ([dateComponents second] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld second ago", [dateComponents second]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld seconds ago", [dateComponents second]];
            }
        }
        
        return cell;
    } else {
        NewsAndOffersTableViewCell *cell = (NewsAndOffersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsAndOffersCell"];
        
        cell.shareButton.tag = indexPath.row;
        [cell.shareButton addTarget:self action:@selector(offerShareButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [cell.postButtonImage addTarget:self action:@selector(offersPostImageButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        PFObject *tempOffersObject = offersArray[indexPath.row];
        
        PFFile *posterImageFile = tempOffersObject[@"posterThumbnailImage"];
        [posterImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                cell.posterProfilePicImageView.image = [UIImage imageWithData:imageData];
            }
        }];
        
        PFFile *messageImageFile = tempOffersObject[@"messageImage"];
        [messageImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                [cell.postButtonImage setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                [offerImagesArray setObject:[UIImage imageWithData:imageData] atIndexedSubscript:indexPath.row];
            }
        }];
        
        cell.posterNameLabel.text = tempOffersObject[@"poster"];
        cell.postTextView.text = tempOffersObject[@"message"];
        
        NSDate *createdAtDate = tempOffersObject.createdAt;
        NSCalendar *gregorianCalender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [gregorianCalender components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
                                                                fromDate:createdAtDate
                                                                  toDate:[NSDate date]
                                                                 options:0];
        
        if ([dateComponents year] > 0) {
            if ([dateComponents year] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld year ago", [dateComponents year]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld years ago", [dateComponents year]];
            }
        } else if ([dateComponents month] > 0) {
            if ([dateComponents month] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld month ago", [dateComponents month]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld months ago", [dateComponents month]];
            }
        } else if ([dateComponents day] > 0) {
            if ([dateComponents day] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld day ago", [dateComponents day]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld days ago", [dateComponents day]];
            }
        } else if ([dateComponents hour] > 0) {
            if ([dateComponents hour] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld hour ago", [dateComponents hour]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld hours ago", [dateComponents hour]];
            }
        } else if ([dateComponents minute] > 0) {
            if ([dateComponents minute] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld minute ago", [dateComponents minute]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld minutes ago", [dateComponents minute]];
            }
        } else if ([dateComponents second] > 0) {
            if ([dateComponents second] == 1) {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld second ago", [dateComponents second]];
            } else {
                cell.createdAtLabel.text = [NSString stringWithFormat:@"%ld seconds ago", [dateComponents second]];
            }
        }
        
        return cell;
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) closeShareView:(UITapGestureRecognizer *) sender {
//    UIView *view = sender.view;
//    NSLog(@"view.tag = %ld", (long)view.tag);
    
    UIView* view = sender.view;
    CGPoint loc = [sender locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if (!shareView.isHidden && (subview.tag == 2 || subview.tag == 0)) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [newsTableView setUserInteractionEnabled:TRUE];
        [offersTableView setUserInteractionEnabled:TRUE];
        [newsButton setUserInteractionEnabled:TRUE];
        [offersButton setUserInteractionEnabled:TRUE];
    }
}

-(void) newsShareButtonPressed:(UIButton *)sender {
    if (shareView.isHidden) {
        [shareView setHidden:FALSE];
        isSharingNews = TRUE;
        sharingIndex = sender.tag;
        
        [sideMenuButton setUserInteractionEnabled:FALSE];
        [largerSideMenuButton setUserInteractionEnabled:FALSE];
        [newsTableView setUserInteractionEnabled:FALSE];
        [offersTableView setUserInteractionEnabled:FALSE];
        [newsButton setUserInteractionEnabled:FALSE];
        [offersButton setUserInteractionEnabled:FALSE];
    }
}

-(void) offerShareButtonPressed:(UIButton *)sender {
    if (shareView.isHidden) {
        [shareView setHidden:FALSE];
        isSharingNews = FALSE;
        sharingIndex = sender.tag;
        
        [sideMenuButton setUserInteractionEnabled:FALSE];
        [largerSideMenuButton setUserInteractionEnabled:FALSE];
        [newsTableView setUserInteractionEnabled:FALSE];
        [offersTableView setUserInteractionEnabled:FALSE];
        [newsButton setUserInteractionEnabled:FALSE];
        [offersButton setUserInteractionEnabled:FALSE];
    }
}

-(void) newsPostImageButtonPressed:(UIButton *)sender {
    PFObject *tempNewsObject = newsArray[sharingIndex];
    
    NSURL *facebookURL = [NSURL URLWithString:tempNewsObject[@"facebookLink"]];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
    }
}

-(void) offersPostImageButtonPressed:(UIButton *)sender {
    PFObject *tempOffersObject = offersArray[sharingIndex];
    
    NSURL *facebookURL = [NSURL URLWithString:tempOffersObject[@"facebookLink"]];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
    }
}

- (IBAction)newsButtonPressed:(id)sender {
    [newsSelectedView setHidden:FALSE];
    [newsTableView setHidden:FALSE];
    [offersSelectedView setHidden:TRUE];
    [offersTableView setHidden:TRUE];
}

- (IBAction)offersButtonPressed:(id)sender {
    [offersSelectedView setHidden:FALSE];
    [offersTableView setHidden:FALSE];
    [newsSelectedView setHidden:TRUE];
    [newsTableView setHidden:TRUE];
}

- (IBAction)mailShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [newsTableView setUserInteractionEnabled:TRUE];
        [offersTableView setUserInteractionEnabled:TRUE];
        [newsButton setUserInteractionEnabled:TRUE];
        [offersButton setUserInteractionEnabled:TRUE];
        
        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
        
        if ([MFMailComposeViewController canSendMail]) {
            emailDialog.mailComposeDelegate = self;
            
            NSString *messageText;
            
            if (isSharingNews) {
                PFObject *tempNewsObject = newsArray[sharingIndex];
                messageText = tempNewsObject[@"message"];
            } else {
                PFObject *tempOffersObject = offersArray[sharingIndex];
                messageText = tempOffersObject[@"message"];
            }
            
            NSString *htmlMsg = [NSString stringWithFormat:@"<html><body><p>%@</p></body></html>", messageText];
            
            UIImage *emailImage = [[UIImage alloc] init];
            if (isSharingNews) {
                emailImage = newsImagesArray[sharingIndex];
            } else {
                emailImage = offerImagesArray[sharingIndex];
            }
            
            NSData *jpegData = UIImageJPEGRepresentation(emailImage, 1.0);
            
            NSString *fileName = @"test";
            fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
            [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            
            NSString *subjectText;
            
            if (isSharingNews) {
                subjectText = @"News from Goyal Co | Hariyana Group";
            } else {
                subjectText = @"Offer from Goyal Co | Hariyana Group";
            }
            
            [emailDialog setSubject:subjectText];
            [emailDialog setMessageBody:htmlMsg isHTML:YES];
            
            [self presentViewController:emailDialog animated:YES completion:NULL];
        } else {
            
        }
    }
}

- (IBAction)facebookShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [newsTableView setUserInteractionEnabled:TRUE];
        [offersTableView setUserInteractionEnabled:TRUE];
        [newsButton setUserInteractionEnabled:TRUE];
        [offersButton setUserInteractionEnabled:TRUE];
        
        NSString *contentURLString;
        NSString *contentTitleString;
        NSString *contentDescriptionString;
        NSString *imageURLString;
        
        if (isSharingNews) {
            PFObject *tempNewsObject = newsArray[sharingIndex];
            contentURLString = tempNewsObject[@"facebookLink"];
            contentTitleString = @"News from Goyal Co | Hariyana Group";
            contentDescriptionString = tempNewsObject[@"message"];
            
            PFFile *postImageFile = tempNewsObject[@"messageImage"];
            imageURLString = postImageFile.url;
        } else {
            PFObject *tempOffersObject = offersArray[sharingIndex];
            contentURLString = tempOffersObject[@"facebookLink"];
            contentTitleString = @"Offer from Goyal Co | Hariyana Group";
            contentDescriptionString = tempOffersObject[@"message"];
            
            PFFile *postImageFile = tempOffersObject[@"messageImage"];
            imageURLString = postImageFile.url;
        }
        
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL URLWithString:contentURLString];
        content.contentTitle = contentTitleString;
        content.imageURL = [NSURL URLWithString:imageURLString];
        content.contentDescription = contentDescriptionString;

        shareButton.shareContent = content;
        [shareButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)messengerShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [newsTableView setUserInteractionEnabled:TRUE];
        [offersTableView setUserInteractionEnabled:TRUE];
        [newsButton setUserInteractionEnabled:TRUE];
        [offersButton setUserInteractionEnabled:TRUE];
        
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        if (isSharingNews) {
            photo.image = newsImagesArray[sharingIndex];
        } else {
            photo.image = offerImagesArray[sharingIndex];
        }
        photo.userGenerated = YES;
        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
        content.photos = @[photo];
        sendButton.shareContent = content;
        [sendButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)whatsappShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [newsTableView setUserInteractionEnabled:TRUE];
        [offersTableView setUserInteractionEnabled:TRUE];
        [newsButton setUserInteractionEnabled:TRUE];
        [offersButton setUserInteractionEnabled:TRUE];
        
        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
            
            UIImage * iconImage;
            if (isSharingNews) {
                iconImage = newsImagesArray[sharingIndex];
            } else {
                iconImage = offerImagesArray[sharingIndex];
            }
            NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
            
            [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
            
            documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
            documentInteractionController.UTI = @"net.whatsapp.image";
            documentInteractionController.delegate = self;
            
            [documentInteractionController presentOpenInMenuFromRect:CGRectMake(20, 167, 279, 338) inView:self.view animated: YES];
            
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
