//
//  WebViewController.m
//  Reader
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize url = _url, webView = _webView;

- (id)initWithURL:(NSURL *)postURL title:(NSString *)postTitle
{
    self = [super init];
    if (self) {
        _url = postURL;
        self.title = postTitle;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
