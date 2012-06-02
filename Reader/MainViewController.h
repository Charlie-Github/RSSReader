//
//  MainViewController.h
//  Reader
//

#import <UIKit/UIKit.h>
#import "KMXMLParser.h"

@interface MainViewController : UITableViewController <KMXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *parseResults;

@end
