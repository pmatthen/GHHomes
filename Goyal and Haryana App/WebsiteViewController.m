//
//  WebsiteViewController.m
//  Goyal and Haryana App
//
//  Created by Poulose Matthen on 27/10/16.
//  Copyright © 2016 Goyal & Co. and Haryana Group. All rights reserved.
//

#import "WebsiteViewController.h"

@interface WebsiteViewController ()

@end

@implementation WebsiteViewController
@synthesize titleLabel, myWebView, activityIndicatorView, goBackButton, goForwardButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attributedString addAttribute:NSKernAttributeName
                              value:@(1.4)
                              range:NSMakeRange(0, [titleLabel.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName
                              value:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                              range:NSMakeRange(0, [titleLabel.text length])];
    
    titleLabel.attributedText = attributedString;
    
    [self.activityIndicatorView startAnimating];
    
    NSURLRequest *myURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.goyalco.com"]];
    [myWebView loadRequest:myURLRequest];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView setHidden:YES];
    
    if(myWebView.canGoBack == YES)
    {
        [goBackButton setHidden:NO];
    } else {
        [goBackButton setHidden:YES];
    }
    
    if(myWebView.canGoForward == YES)
    {
        [goForwardButton setHidden:NO];
    } else {
        [goForwardButton setHidden:YES];
    }
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSURLProtectionSpace *protectionSpace = [challenge protectionSpace];
    id<NSURLAuthenticationChallengeSender> sender = [challenge sender];
    
    if ([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef trust = [[challenge protectionSpace] serverTrust];
        NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:trust];
        
        [sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [sender performDefaultHandlingForAuthenticationChallenge:challenge];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error : %@",error);
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goBackButtonPressed:(id)sender {
    [myWebView goBack];
}

- (IBAction)goForwardButtonPressed:(id)sender {
    [myWebView goForward];
}

@end
