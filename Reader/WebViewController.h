//
//  WebViewController.h
//  Reader
//
//  Created by Kieran McGrady on 23/04/2012.
//  Copyright (c) 2012 HotRod software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIWebView *webView;

@end
