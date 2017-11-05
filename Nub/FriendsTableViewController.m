//
//  FriendsTableViewController.m
//  Nub
//
//  Created by Yangzong Guo on 12/6/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "FriendsModel.h"
#import "PopOverViewController.h"
@interface FriendsTableViewController ()
@property FriendsModel *model;
@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [FriendsModel sharedModel];
    [self.model sort];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataReceived:) name:@"received" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) dataReceived:(NSNotification *) notification
{

    if ([[notification name] isEqualToString:@"received"]) {
        NSLog (@"Received the test notification");
        [self.tableView reloadData];
    }
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"received" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfFriends];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *friend = [self.model friendAtIndex:indexPath.row];
    cell.textLabel.text = friend[@"name"];
    cell.detailTextLabel.text = friend[@"status"];
    //NSLog(friend[@"picture"]);
    cell.imageView.image = friend[@"picture"];
    //cell.imageView.image = [UIImage imageNamed:@"michael.jpg"];
    //cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row + 1];
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PopOverViewController *destViewController = [segue destinationViewController];
    destViewController.statusText = cell.detailTextLabel.text;
    
    
}*/



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowStatus"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PopOverViewController *destViewController = segue.destinationViewController;
        NSDictionary *status = [self.model friendAtIndex:indexPath.row];
        destViewController.statusText = status[@"status"];
        destViewController.timeText = status[@"lastUpdated"];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
