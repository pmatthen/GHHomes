//
//  ProjectViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 20/07/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectViewTableViewCell.h"
#import "ProjectInfoViewController.h"
#import "ProjectStatusViewController.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

#define DURATION_BEFORE_SLIDE_TRANSITION 2.0

@interface ProjectViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *blocksArray;
@property (nonatomic, strong) NSMutableArray *blockNamesArray;
@property (nonatomic, strong) NSMutableDictionary *blockImagesDictionary;
@property (nonatomic, strong) NSMutableArray *blockImagesArray;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) PFObject *currentBlockObject;
@property (nonatomic, strong) NSNumber *blockPhotoCount;
@property int sharingIndex;
@property (nonatomic, strong) UITapGestureRecognizer *letterTapRecognizer;
@property(nonatomic, strong) FBSDKShareButton *shareButton;
@property(nonatomic, strong) FBSDKSendButton *sendButton;
@property (retain) UIDocumentInteractionController *documentInteractionController;
@property int screenHeight;

@end

@implementation ProjectViewController
@synthesize projectName, titleLabel, projectObject, blocksArray, blockNamesArray, blockImagesDictionary, blockImagesArray, myScrollView, pageControl, currentBlockObject, myTableView, blockSelectionButton, blockPhotoCount, blockSelectionButtonLabel, projectInfoLabel, projectStatusLabel, locationLabel, screenHeight, shareView, shareLabel, mailLabel, facebookLabel, messengerLabel, whatsappLabel, largerSideMenuButton, sideMenuButton, blockPhotoShareButton, projectInfoButton, projectStatusButton, locationButton, sharingIndex, letterTapRecognizer, shareButton, sendButton, documentInteractionController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    blocksArray = [NSMutableArray new];
    blockNamesArray = [NSMutableArray new];
    blockImagesDictionary = [NSMutableDictionary new];
    blockImagesArray = [NSMutableArray new];
    blockPhotoCount = 0;
    sharingIndex = 0;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [blockSelectionButton setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.94 alpha:1.0]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:blockSelectionButtonLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, blockSelectionButtonLabel.text.length)];
    [blockSelectionButtonLabel setAttributedText:attributedString];
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[projectName uppercaseString]];
    [attributedString2 addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, projectName.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName
                             value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                             range:NSMakeRange(0, projectName.length)];
    
    titleLabel.attributedText = attributedString2;
    
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:projectInfoLabel.text];
    [attributedString3 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, projectInfoLabel.text.length)];
    
    projectInfoLabel.attributedText = attributedString3;
    
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:projectStatusLabel.text];
    [attributedString4 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, projectStatusLabel.text.length)];
    
    projectStatusLabel.attributedText = attributedString4;
    
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:locationLabel.text];
    [attributedString5 addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, locationLabel.text.length)];
    
    locationLabel.attributedText = attributedString5;
    
    shareView.layer.cornerRadius = 2;
    shareView.layer.masksToBounds = YES;
    shareView.layer.borderWidth = 1;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"projectName = '%@'", projectName]];
    PFQuery *query = [PFQuery queryWithClassName:@"BlockIndex" predicate:predicate];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count] > 0 ) {
                [blocksArray addObjectsFromArray:objects];
                
                for (int i = 0; i < [blocksArray count]; i++) {
                    PFObject *tempBlockObject = blocksArray[i];
                    NSString *orderString = tempBlockObject[@"order"];
                    [blockImagesDictionary setObject:tempBlockObject forKey:orderString];
                }
                // Make Method to initialize block buttons
                [self initializeBlockSelection:0];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
    
    shareButton = [[FBSDKShareButton alloc] init];
    [self.view addSubview:shareButton];
    [shareButton setHidden:TRUE];
    
    sendButton = [[FBSDKSendButton alloc] init];
    [self.view addSubview:sendButton];
    [sendButton setHidden:TRUE];
}

-(void)viewDidAppear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextSlide:) object:nil];
    [myScrollView setContentOffset:CGPointMake(0, myScrollView.contentOffset.y) animated:YES];
    [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [blockNamesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectViewTableViewCell *cell = (ProjectViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0];
    [cell setSelectedBackgroundView:bgColorView];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[blockNamesArray[indexPath.row] uppercaseString]];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, [blockNamesArray[indexPath.row] uppercaseString].length)];
    
    cell.cellTitleLabel.attributedText = attributedString;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setHidden:!tableView.hidden];
    [letterTapRecognizer setCancelsTouchesInView:!letterTapRecognizer.cancelsTouchesInView];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[blockNamesArray[indexPath.row] uppercaseString]];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, [blockNamesArray[indexPath.row] uppercaseString].length)];
    [blockSelectionButtonLabel setAttributedText:attributedString];
    
    [blockSelectionButton setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.94 alpha:1.0]];
    
    [myScrollView removeFromSuperview];
    PFObject *tempBlockObject = [blockImagesDictionary objectForKey:[NSNumber numberWithInteger:(indexPath.row + 1)]];
    currentBlockObject = tempBlockObject;
    [self updateScrollView:(int)indexPath.row];
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

- (void) initializeBlockSelection:(int)blockAtIndex {
    PFObject *tempBlockObject = [blockImagesDictionary objectForKey:[NSNumber numberWithInteger:(blockAtIndex + 1)]];
    currentBlockObject = tempBlockObject;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[tempBlockObject[@"blockName"] uppercaseString]];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(1.4)
                             range:NSMakeRange(0, [tempBlockObject[@"blockName"] uppercaseString].length)];
    [blockSelectionButtonLabel setAttributedText:attributedString];
    
    for (int i = 1; i < [blockImagesDictionary count] + 1; i++) {
        tempBlockObject = [blockImagesDictionary objectForKey:[NSNumber numberWithInteger:i]];
        [blockNamesArray setObject:tempBlockObject[@"blockName"] atIndexedSubscript:(i - 1)];
    }
    
    [myTableView reloadData];
    [self updateScrollView:blockAtIndex];
}

- (void) updateScrollView:(int)blockAtIndex {
    PFObject *tempBlockObject = [blockImagesDictionary objectForKey:[NSNumber numberWithInteger:blockAtIndex + 1]];
    
    [blockImagesArray removeAllObjects];
    blockPhotoCount = tempBlockObject[@"blockImagesCount"];
    
    CGRect myBounds;
    
    switch (screenHeight) {
        case 480:
            myBounds = CGRectMake(0, 64, 320, 152);
            break;
        case 568:
            myBounds = CGRectMake(0, 75, 320, 180);
            break;
        case 667:
            myBounds = CGRectMake(0, 84, 375, 211);
            break;
        case 736:
            myBounds = CGRectMake(0, 99, 414, 233);
            break;
        default:
            myBounds = CGRectMake(0, 75, 320, 180);
            break;
    }
    
    //init scollview
    myScrollView = [[UIScrollView alloc] initWithFrame:myBounds];
    myScrollView.delegate = self;
    myScrollView.pagingEnabled = YES;
    
    [self.view addSubview:myScrollView];
    
    //Ajout des covers classiques
    for (int i = 0; i < [blockPhotoCount integerValue]; i++) {
        //Vue 1
        [tempBlockObject[[NSString stringWithFormat:@"blockImage%d", (i + 1)]] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                CGRect frame;
                frame.origin.x = myScrollView.frame.size.width * i;
                frame.origin.y = 0;
                frame.size = myScrollView.frame.size;
                
                UIImage *image = [UIImage imageWithData:data];
                [blockImagesArray setObject:image atIndexedSubscript:i];
                // image can now be set on a UIImageView
                UIImageView *myImageView = [[UIImageView alloc] initWithFrame:frame];
                [myImageView setImage:image];
                [myScrollView addSubview:myImageView];
            } else {
                NSLog(@"error = %@", error.localizedDescription);
            }
        }];
    }
    
    //Content Size Scrollview
    //    scrollViewBack.contentSize = CGSizeMake(scrollViewBack.frame.size.width * ([myCovers count]), scrollViewBack.frame.size.height);
    //    [self.view addSubview:scrollViewBack];
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width*([blockPhotoCount integerValue]), myScrollView.frame.size.height);
    [self.view addSubview:myScrollView];
    
    //Page Control
    float cGRectYValue;
    
    switch (screenHeight) {
        case 480:
            cGRectYValue = 182;
            break;
        case 568:
            cGRectYValue = 215;
            break;
        case 667:
            cGRectYValue = 252;
            break;
        case 736:
            cGRectYValue = 277;
            break;
        default:
            cGRectYValue = 182;
            break;
    }
    
    for (UIView *myPageControl in self.view.subviews) {
        if (myPageControl.tag == 7) {
            [myPageControl removeFromSuperview];
        }
    }
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.tag = 7;
    pageControl.frame = CGRectMake(((self.view.frame.size.width/2) - (pageControl.frame.size.width/2)), cGRectYValue, pageControl.frame.size.width, pageControl.frame.size.height);
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = [blockPhotoCount integerValue];
    [self.view addSubview:pageControl];
    
    [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    CGFloat pageWidth = myScrollView.frame.size.width;
    NSInteger offsetLooping = 1;
    int page = floor((myScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + offsetLooping;
    pageControl.currentPage = page;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = myScrollView.frame.size.width;
    int page = (myScrollView.contentOffset.x + (0.5f * pageWidth))/pageWidth;
    pageControl.currentPage = page;
    
    if (scrollView.isDragging) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextSlide:) object:nil];
        [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
    }
}

-(IBAction)nextSlide:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextSlide:) object:nil];
    
    if (myScrollView.contentOffset.x < (self.view.frame.size.width * ([blockPhotoCount integerValue] - 1))) {
        [myScrollView setContentOffset:CGPointMake(myScrollView.contentOffset.x + (self.view.frame.size.width), myScrollView.contentOffset.y) animated:YES];
        [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
    } else {
        [myScrollView setContentOffset:CGPointMake(0, myScrollView.contentOffset.y) animated:YES];
        [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)blockSelectionButtonPressed:(id)sender {
    [letterTapRecognizer setCancelsTouchesInView:!letterTapRecognizer.cancelsTouchesInView];
    [myTableView setHidden:!myTableView.hidden];
    
    if (myTableView.hidden) {
        [blockSelectionButton setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.94 alpha:1.0]];
    } else {
        [blockSelectionButton setBackgroundColor:[UIColor colorWithRed:0.27 green:0.78 blue:0.86 alpha:1.0]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProjectInfoSegue"]) {
        ProjectInfoViewController *myProjectInfoViewController = (ProjectInfoViewController *) segue.destinationViewController;
        myProjectInfoViewController.projectName = projectName;
        myProjectInfoViewController.projectObject = projectObject;
    }
    if ([segue.identifier isEqualToString:@"ProjectStatusSegue"]) {
        ProjectStatusViewController *myProjectStatusViewController = (ProjectStatusViewController *) segue.destinationViewController;
        myProjectStatusViewController.blockObject = currentBlockObject;
        myProjectStatusViewController.projectObject = projectObject;
    }
}

- (IBAction)projectInfoButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"ProjectInfoSegue" sender:self];
}

- (IBAction)projectStatusButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"ProjectStatusSegue" sender:self];
}

- (IBAction)locationButtonPressed:(id)sender {
    NSString *destinationAddress = projectObject[@"location"];
    NSString *finalString = [destinationAddress stringByReplacingOccurrencesOfString:@" " withString: @"+"];
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%@&directionsmode=driving", finalString]]];
    } else {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=Current+Location&daddr=%@", finalString]]];
    }
}

-(void) closeShareView:(UITapGestureRecognizer *) sender {
    //    UIView *view = sender.view;
    //    NSLog(@"view.tag = %ld", (long)view.tag);
    
    UIView* view = sender.view;
    CGPoint loc = [sender locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    
    if (!shareView.isHidden && (subview.tag == 2 || subview.tag == 0)) {
        [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [blockPhotoShareButton setUserInteractionEnabled:TRUE];
        [projectInfoButton setUserInteractionEnabled:TRUE];
        [projectStatusButton setUserInteractionEnabled:TRUE];
        [locationButton setUserInteractionEnabled:TRUE];
        
        [self.view removeGestureRecognizer:letterTapRecognizer];
    }
}

- (IBAction)blockPhotoShareButtonPressed:(id)sender {
    if (shareView.isHidden) {
        letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeShareView:)];
        letterTapRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:letterTapRecognizer];
        
        [self.view bringSubviewToFront:shareView];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextSlide:) object:nil];
        [shareView setHidden:FALSE];
        sharingIndex = pageControl.currentPage;
        
        [sideMenuButton setUserInteractionEnabled:FALSE];
        [largerSideMenuButton setUserInteractionEnabled:FALSE];
        [blockPhotoShareButton setUserInteractionEnabled:FALSE];
        [projectInfoButton setUserInteractionEnabled:FALSE];
        [projectStatusButton setUserInteractionEnabled:FALSE];
        [locationButton setUserInteractionEnabled:FALSE];
    }
}

- (IBAction)mailShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [blockPhotoShareButton setUserInteractionEnabled:TRUE];
        [projectInfoButton setUserInteractionEnabled:TRUE];
        [projectStatusButton setUserInteractionEnabled:TRUE];
        [locationButton setUserInteractionEnabled:TRUE];
        
        MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
        emailDialog.mailComposeDelegate = self;
        
        NSString *messageText = @"Check out what the project is currently looking like.";
        
        NSString *htmlMsg = [NSString stringWithFormat:@"<html><body><p>%@</p></body></html>", messageText];
        
        PFObject *tempBlockObject = currentBlockObject;
        
        PFFile *messageImageFile = tempBlockObject[[NSString stringWithFormat:@"blockImage%d", (sharingIndex + 1)]];
        [messageImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                UIImage *emailImage = [[UIImage alloc] init];
                emailImage = [UIImage imageWithData:imageData];
                [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
                
                NSData *jpegData = UIImageJPEGRepresentation(emailImage, 1.0);
                
                NSString *fileName = @"blockPhoto";
                fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
                [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
                
                NSString *subjectText = @"Latest photo from Goyal Co | Hariyana Group";
                
                [emailDialog setSubject:subjectText];
                [emailDialog setMessageBody:htmlMsg isHTML:YES];
                
                [self presentViewController:emailDialog animated:YES completion:NULL];
            }
        }];
    }
}

- (IBAction)facebookShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [blockPhotoShareButton setUserInteractionEnabled:TRUE];
        [projectInfoButton setUserInteractionEnabled:TRUE];
        [projectStatusButton setUserInteractionEnabled:TRUE];
        [locationButton setUserInteractionEnabled:TRUE];
        
        NSString *contentURLString;
        NSString *contentTitleString;
        NSString *contentDescriptionString;
        NSString *imageURLString;
        
        PFObject *tempBlockObject = currentBlockObject;
        
        PFFile *postImageFile = tempBlockObject[[NSString stringWithFormat:@"blockImage%d", (sharingIndex + 1)]];
        imageURLString = postImageFile.url;
        [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
        
        contentURLString = postImageFile.url;
        contentTitleString = @"Latest photo from Goyal Co | Hariyana Group";
        contentDescriptionString = @"Check out what the project is currently looking like.";
        
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
        [blockPhotoShareButton setUserInteractionEnabled:TRUE];
        [projectInfoButton setUserInteractionEnabled:TRUE];
        [projectStatusButton setUserInteractionEnabled:TRUE];
        [locationButton setUserInteractionEnabled:TRUE];
        
        PFObject *tempBlockObject = currentBlockObject;
        
        PFFile *messageImageFile = tempBlockObject[[NSString stringWithFormat:@"blockImage%d", (sharingIndex + 1)]];
        [messageImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                photo.image = [UIImage imageWithData:imageData];
                photo.userGenerated = YES;
                FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
                content.photos = @[photo];
                sendButton.shareContent = content;
                
                [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
                
                [sendButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }];
    }
}

- (IBAction)whatsappShareButtonPressed:(id)sender {
    if (shareView.isHidden == FALSE) {
        [shareView setHidden:TRUE];
        
        [sideMenuButton setUserInteractionEnabled:TRUE];
        [largerSideMenuButton setUserInteractionEnabled:TRUE];
        [blockPhotoShareButton setUserInteractionEnabled:TRUE];
        [projectInfoButton setUserInteractionEnabled:TRUE];
        [projectStatusButton setUserInteractionEnabled:TRUE];
        [locationButton setUserInteractionEnabled:TRUE];
        
        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
            
            PFObject *tempBlockObject = currentBlockObject;
            
            PFFile *messageImageFile = tempBlockObject[[NSString stringWithFormat:@"blockImage%d", (sharingIndex + 1)]];
            [messageImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    UIImage * iconImage;
                    iconImage = [UIImage imageWithData:imageData];
                    
                    NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
                    
                    [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
                    
                    documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
                    documentInteractionController.UTI = @"net.whatsapp.image";
                    documentInteractionController.delegate = self;
                    
                    [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
                    
                    [documentInteractionController presentOpenInMenuFromRect:CGRectMake(20, 167, 279, 338) inView:self.view animated: YES];
                }
             }];
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [self performSelector:@selector(nextSlide:) withObject:nil afterDelay:DURATION_BEFORE_SLIDE_TRANSITION];
            
            [alert show];
        }
    }
}

@end
