//
//  IndividualMusicGroupTableViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//  Figure out how to get buttons in UITableViewCells working!!! (Online tutorials)

#import "IndividualMusicGroupTableViewController.h"
#import "SongPostTableViewCell.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

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
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath:indexPath];
    
    SongPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];
    
    PFObject *songPost = [self.songPosts objectAtIndex: indexPath.row];
    [songPost saveInBackground];
    
    NSData *imageData = songPost[@"coverArtData"];
    cell.songCoverArtImageView.image = [UIImage imageWithData: imageData];
    
    cell.songNameLabel.text = songPost[@"songName"];
    cell.artistNameLabel.text = songPost[@"songArtist"];
    cell.albumNameLabel.text = songPost[@"albumName"];
    cell.userDescriptionLabel.text = songPost[@"userDescription"];
    
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *) result;
            NSString *preText = @"Shared by ";
            cell.usernameLabel.text = [preText stringByAppendingString: userDictionary[@"name"]];
        }
    }];
    
    cell.playSongPreviewButton.tag = indexPath.row;
    [cell.playSongPreviewButton addTarget: self action: @selector(playSongPreviewButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
    //cell.playSpotifyTrackButton.tag = indexPath.row;
    //cell.likeSongButton.tag = indexPath.row;
    
//    NSString *urlString = songPost[@"artworkUrl60"];
//    NSLog(@"The artwork URL is %@", urlString);
//    NSData *imageData = songPost[@"coverArtData"];
//    NSLog(@"IMAGE DATA IS %@", imageData);
//    UIImageView *songCoverArtImageView = (UIImageView *) [cell viewWithTag: 105];
//    songCoverArtImageView.image = [UIImage imageWithData: imageData];
//    UILabel *songNameLabel = (UILabel *) [cell viewWithTag: 101];
//    songNameLabel.text = songPost[@"songName"];
//    UILabel *songArtistNameLabel = (UILabel *) [cell viewWithTag: 102];
//    songArtistNameLabel.text = songPost[@"songArtist"];
//    UILabel *songAlbumNameLabel = (UILabel *) [cell viewWithTag: 103];
//    songAlbumNameLabel.text = songPost[@"albumName"];
//    UILabel *userDescriptionLabel = (UILabel *) [cell viewWithTag: 104];
//    userDescriptionLabel.text = songPost[@"userDescription"];
    //[self.playSongPreviewButton addTarget: self action:@selector(playSongPreviewButtonPressed: sender:) forControlEvents: UIControlEventTouchUpInside];
    
    NSLog(@"THE DESCRIPTION IS %@", songPost[@"userDescription"]);
    
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

//- (IBAction)playSongPreviewButtonPressed:(UIButton *)sender {
//    //NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex: 1];
//    
//    NSLog(@"EVENT RECEIVED!");
////    PFQuery *query = [PFQuery queryWithClassName: @"SongPost"];
////    [query whereKey:(NSString *) equalTo:(id)]
//    
//    NSLog(@"%ld", (long)sender.tag);
//    
//    PFObject *selectedSongPost = [self.songPosts objectAtIndex: sender.tag];
//    [selectedSongPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            NSLog(@"Saving of song succeeded!");
//            NSLog(@"The song name is %@", selectedSongPost[@"songName"]);
//            NSLog(@"The preview URL is %@", selectedSongPost[@"previewURLString"]);
//        }
//        else {
//            NSLog(@"ERROR IN SAVING SONG!");
//        }
//    }];
//    
//    self.audioPlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString: selectedSongPost[@"previewURLString"]]];
//    [self.audioPlayer prepareToPlay];
//}

- (void) playSongPreviewButtonPressed: (id) sender {
    UIButton *senderButton = (UIButton *) sender;
    NSLog(@"Row tapped = %ld", (long)senderButton.tag);
    
    PFObject *selectedSongPost = [self.songPosts objectAtIndex: senderButton.tag];
    [selectedSongPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Saving of song succeeded!");
            NSLog(@"The song name is %@", selectedSongPost[@"songName"]);
            NSLog(@"The preview URL is %@", selectedSongPost[@"previewURLString"]);
        }
        else {
            NSLog(@"ERROR IN SAVING SONG!");
        }
    }];

    self.audioPlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString: selectedSongPost[@"previewURLString"]]];
    [self.audioPlayer prepareToPlay];
}

- (IBAction)likeSongButtonPressed:(UIButton *)sender {
    
}

- (IBAction)spotifyLinkButtonPressed:(UIButton *)sender {
    
}

@end
