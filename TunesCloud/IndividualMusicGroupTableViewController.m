//
//  IndividualMusicGroupTableViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "IndividualMusicGroupTableViewController.h"

@interface IndividualMusicGroupTableViewController ()

@end

@implementation IndividualMusicGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.songPosts = [[NSArray alloc] init];
    
    NSLog(@"THE MUSIC GROUP NAME IS %@", self.musicGroupName);
    
    PFQuery *query = [PFQuery queryWithClassName: @"SongPost"];
    //[query whereKey: @"groupName" equalTo: self.musicGroupName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"NO ERROR IN QUERYING OBJECT!");
            for (PFObject *object in objects) {
                self.sharedSong = [objects objectAtIndex: [objects count] - 1];
                self.songPosts = [[NSArray alloc] initWithArray: objects];
                [self.tableView reloadData];
            }
        }
        else {
            NSLog(@"Object Query Error");
        }
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.songPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
    
    PFObject *songPost = [self.songPosts objectAtIndex: indexPath.row];
    
    NSString *urlString = songPost[@"artworkUrl60"];
    NSURL *imageURL = [NSURL URLWithString: urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
    UIImageView *songCoverArtImageView = (UIImageView *) [cell viewWithTag: 100];
    songCoverArtImageView.image = [UIImage imageWithData: imageData];
    UILabel *songNameLabel = (UILabel *) [cell viewWithTag: 101];
    songNameLabel.text = songPost[@"songName"];
    UILabel *songArtistNameLabel = (UILabel *) [cell viewWithTag: 102];
    songArtistNameLabel.text = songPost[@"songArtist"];
    UILabel *songAlbumNameLabel = (UILabel *) [cell viewWithTag: 103];
    songAlbumNameLabel.text = songPost[@"albumName"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
