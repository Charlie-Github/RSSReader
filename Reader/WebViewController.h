//
//  WebViewController.h
//  Reader
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIWebView *webView;

@end
