//
//  SelectGroupTableViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/14/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "SelectGroupTableViewController.h"
#import "GroupsTableViewController.h"
#import "IndividualMusicGroupTableViewController.h"

@interface SelectGroupTableViewController ()

@end

@implementation SelectGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GroupsTableViewController *groupsTVC = [[GroupsTableViewController alloc] init];
    self.musicGroups = groupsTVC.musicGroups;
    
    NSLog(@"%@", self.sharedSong[@"songName"]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: YES];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName: @"MusicGroup"];
    //fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"date" ascending: YES]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    
    NSArray *fetchedMusicGroups = [context executeFetchRequest: fetchRequest error: &error];
    self.musicGroups = [fetchedMusicGroups mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.musicGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
 
    cell.textLabel.text = [[self.musicGroups objectAtIndex: indexPath.row] getMusicGroupName];
    cell.detailTextLabel.text = [[self.musicGroups objectAtIndex: indexPath.row] getMusicStyle];
    
    return cell;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [IndividualMusicGroupTableViewController class]]) {
        if ([segue.identifier isEqualToString: @"postToGroup"]) {
            IndividualMusicGroupTableViewController *nextViewController = [[IndividualMusicGroupTableViewController alloc] init];
            self.sharedSong = nextViewController.sharedSong;
        }
    }
}

@end
