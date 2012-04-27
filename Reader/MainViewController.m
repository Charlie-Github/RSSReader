//
//  MainViewController.m
//  Reader
//

#import "MainViewController.h"
#import "KMXMLParser.h"
#import "WebViewController.h"

@interface MainViewController ()

@end

@implementation NSString (mycategory)

- (NSString *)stringByStrippingHTML 
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s; 
}

@end

@implementation MainViewController
@synthesize parseResults = _parseResults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Sets the navigation bar title
    self.title = @"News";
    //Set table row height so it can fit title & 2 lines of summary
    self.tableView.rowHeight = 85;
    
    //Parse feed
    KMXMLParser *parser = [[KMXMLParser alloc] initWithURL:@"http://rss.cnn.com/rss/cnn_topstories.rss" delegate:nil];
    _parseResults = [parser posts];

    [self stripHTMLFromSummary];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)stripHTMLFromSummary {
    int i = 0;
    int count = self.parseResults.count;
    //cycles through each 'summary' element stripping HTML
    while (i < count) {
        NSString *tempString = [[self.parseResults objectAtIndex:i] objectForKey:@"summary"];
        NSString *strippedString = [tempString stringByStrippingHTML];
        NSMutableDictionary *dict = [self.parseResults objectAtIndex:i];
        [dict setObject:strippedString forKey:@"summary"];
        [self.parseResults replaceObjectAtIndex:i withObject:dict];
        i++;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.parseResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //Check if cell is nil. If it is create a new instance of it
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure titleLabel
    cell.textLabel.text = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.numberOfLines = 2;
    //Configure detailTitleLabel
    cell.detailTextLabel.text = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"summary"];

    cell.detailTextLabel.numberOfLines = 2;
    
    //Set accessoryType
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [NSURL URLWithString:[[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"link"]];
    NSString *title = [[self.parseResults objectAtIndex:indexPath.row] objectForKey:@"title"];
    WebViewController *vc = [[WebViewController alloc] initWithURL:url title:title];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
