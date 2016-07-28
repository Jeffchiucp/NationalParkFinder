//
//  WebViewController.m
//  NationalParkFinder
//
//  Created by Jeff on 6/25/16.
//  Copyright © 2016 Jeff Chiu. All rights reserved.
//


#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

//Need to make sure delegate is set, or the activity indicator won't be able to know if the webView started or ended loading
- (void) webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

//dismisses webView
- (IBAction)onBackButtonPress:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
