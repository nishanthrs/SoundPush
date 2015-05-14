//
//  ITunesSearchResultsTableViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "ITunesSearchResultsTableViewController.h"
//#import "CustomiTunesSearchTableViewCell.h"
#import "ITunesAPIController.h"
#import "ITunesSongInfoViewController.h"
#import "SongInfo.h"

@interface ITunesSearchResultsTableViewController ()

@end

@implementation ITunesSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden: YES];
    
    self.songSearchBar.delegate = self;
    self.songSearchTableView.delegate = self;
    
    //ITunesAPIController.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.iTunesAPI = [[ITunesAPIController alloc] init];
    self.iTunesAPI.delegate = self;
}

#pragma mark - Delegate method implementation

- (void) didReceiveITunesAPIResults:(NSDictionary *)results {
    NSMutableArray *resultsArray = results[@"results"];
    //NSLog(@"WHY ISN'T IT PRINTING?");
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableData = resultsArray;
        [self.songSearchTableView reloadData];
    });
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
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CustomCell" forIndexPath:indexPath];
    
    //CustomiTunesSearchTableViewCell *cell = (CustomiTunesSearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier: @"CustomiTunesSearchTableViewCell"];
    
    if (cell == nil) {
        //NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"CustomiTunesSearchTableViewCell" owner: self options: nil];
        //cell = [nib objectAtIndex: 0];
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"CustomCell"];
    }
    
    NSDictionary *rowData = self.tableData[indexPath.row];
    
    //cell.textLabel.text = rowData[@"trackName"];
    
    NSString *urlString = rowData[@"artworkUrl60"];
    NSURL *imageURL = [NSURL URLWithString: urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
    
    UIImageView *songCoverArtImageView = (UIImageView *) [cell viewWithTag: 100];
    songCoverArtImageView.image = [UIImage imageWithData: imageData];
    UILabel *songNameLabel = (UILabel *) [cell viewWithTag: 101];
    songNameLabel.text = rowData[@"trackName"];
    UILabel *songArtistNameLabel = (UILabel *) [cell viewWithTag: 102];
    songArtistNameLabel.text = rowData[@"artistName"];
    UILabel *songAlbumNameLabel = (UILabel *) [cell viewWithTag: 103];
    songAlbumNameLabel.text = rowData[@"collectionName"];
    
//    cell.songNameLabel.text = rowData[@"trackName"];
//    cell.songAlbumNameLabel.text = rowData[@"collectionName"];
//    cell.songGenreNameLabel.text = rowData[@"primaryGenreName"];
//    cell.songCoverArtImageView.image = [UIImage imageWithData: imageData];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite: 0.6 alpha: 1.0];
    
   // cell.imageView.image = [UIImage imageWithData: imageData];
    
    //NSString *formattedPrice = rowData[@"formattedPrice"];
    
    //cell.detailTextLabel.text = [NSString stringWithFormat: @"$%@", rowData[@"collectionPrice"]];
    //cell.detailTextLabel.text = rowData[@"primaryGenreName"];
    
    return cell;
}

- (void) searchBar: (UISearchBar *) searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [self.tableData removeAllObjects];
    }
    else {
        [self.tableData removeAllObjects];
        [self.iTunesAPI searchiTunesFor: searchText];
       // NSLog(@"%@", searchText);
    }
    [self.songSearchTableView reloadData];
}

- (void) searchBarSearchButtonClicked: (UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
   // [self.iTunesAPI searchiTunesFor: @"Maroon 5"];
}

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *songData = self.tableData[indexPath.row];
    NSString *songName = songData[@"trackName"];
    NSString *songAlbum = songData[@"collectionName"];
    NSString *songGenre = songData[@"primaryGenreName"];
    NSString *songPreviewURL = songData[@"previewUrl"];
    UIImageView *songCoverArt = [[UIImageView alloc] initWithImage: [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: songData[@"artworkUrl60"]]]]];
    
    //NSIndexPath *indexPath = [self.songSearchTableView indexPathForSelectedRow];
    //NSDictionary *songData = self.tableData[indexPath];
//    [self.mediaPlayer stop];
//    NSLog(@"The play URL of the song is %@", songData[@"previewUrl"]);
//    [self.mediaPlayer setContentURL: [NSURL URLWithString: songData[@"previewURL"]]];
//    [self.mediaPlayer play];
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    //if (cell) {
    //[sender setTitle: @"Stop" forState: UIControlStateNormal];
    //}
    
    NSString *songInfo = [NSString stringWithFormat: @"This is the song info: %@, %@, %@", songName, songAlbum, songGenre];
    
    ITunesSongInfoViewController *nextViewController = [[ITunesSongInfoViewController alloc] init];
    SongInfo *allSongInformation = [[SongInfo alloc] initWithSongInfo: songName andAlbum: songAlbum andGenre: songGenre andCoverArt:songCoverArt andPreviewURL: songPreviewURL];
    nextViewController.songInformation = allSongInformation;
//    nextViewController.songInformation.songName = songName;
//    nextViewController.songInformation.albumName = songAlbum;
//    nextViewController.songInformation.genreName = songGenre;
//    nextViewController.songInformation.songCoverArt = songCoverArt;
    
    //NSLog(@"%@", songName);
    UIAlertView *songInfoAlertView = [[UIAlertView alloc] initWithTitle: @"Song Information" message: songInfo delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil, nil];
    [songInfoAlertView show];
    
    //[self performSegueWithIdentifier: @"songInfoSegue" sender: self];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@", sender);
    if ([sender isKindOfClass: [UITableViewCell class]]) {
        if ([segue.destinationViewController isKindOfClass: [ITunesSongInfoViewController class]]) {
            if ([segue.identifier isEqualToString: @"songInfoSegue"]) {
                //[self performSegueWithIdentifier: @"songInfoSegue" sender: self];
                NSLog(@"AWESOME");
                NSIndexPath *indexPath = [self.songSearchTableView indexPathForSelectedRow];
                ITunesSongInfoViewController *nextViewController = segue.destinationViewController;
                
                NSDictionary *songData = self.tableData[indexPath.row];
                NSString *songName = songData[@"trackName"];
                NSString *songAlbum = songData[@"collectionName"];
                NSString *songGenre = songData[@"primaryGenreName"];
                NSString *songPreviewURL = songData[@"previewUrl"];
                NSString *urlString = songData[@"artworkUrl60"];
                NSURL *imageURL = [NSURL URLWithString: urlString];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
                UIImageView *songCoverArtImageView = [[UIImageView alloc] initWithImage: [UIImage imageWithData: imageData]];
                //songCoverArtImageView.image = [UIImage imageWithData: imageData];
                //UIImageView *songCoverArt = [[UIImageView alloc] initWithImage: [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: songData[@"artworkUrl60"]]]]];
                SongInfo *allSongInformation = [[SongInfo alloc] initWithSongInfo : songName andAlbum : songAlbum andGenre : songGenre andCoverArt : songCoverArtImageView andPreviewURL: songPreviewURL];
                nextViewController.songInformation = allSongInformation;
                if ([nextViewController.songInformation.songName isEqualToString: songName]) {
                    NSLog(@"%@", nextViewController.songInformation.songCoverArt);
                    NSLog(@"AWESOMENESS");
                }
            }
        }
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

@end
