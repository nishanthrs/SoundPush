//
//  ITunesSongInfoViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/11/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "ITunesSongInfoViewController.h"
#import <Parse/Parse.h>

@interface ITunesSongInfoViewController ()

@end

@implementation ITunesSongInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden: NO];
    
    self.songNameLabel.text = self.songInformation.songName;
    self.albumNameLabel.text = self.songInformation.albumName;
    self.songGenreLabel.text = self.songInformation.genreName;
    self.songCoverArtImageView.image = self.songInformation.songCoverArt.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//}

- (IBAction)previewButtonPressed:(UIButton *)sender {
    //[self.mediaPlayer stop];
    NSLog(@"The play URL of the song is %@", self.songInformation.previewURL);
//    self.mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString: self.songInformation.previewURL]];
//    //[self presentMoviePlayerViewControllerAnimated: self.mediaPlayer];
//    [self.mediaPlayer play];
    self.mediaPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL: [NSURL URLWithString: self.songInformation.previewURL]];
    [self presentMoviePlayerViewControllerAnimated: self.mediaPlayer];
    [self.mediaPlayer.moviePlayer play];
    //[sender setTitle: @"Stop" forState: UIControlStateNormal];
}

- (IBAction)shareButtonPressed:(UIButton *)sender {
    
    self.songCoverArtData = UIImagePNGRepresentation(self.songInformation.songCoverArt.image);
    NSLog(@"DATA FROM THE IMAGE: %@", self.songCoverArtData);
    self.songCoverArtDataFromImage = [PFFile fileWithData: self.songCoverArtData];
    
    [self.songCoverArtDataFromImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Cover Art Data saved successfully!");
        }
        else if (error) {
            NSLog(@"DID NOT FREAKING SAVE DATA");
        }
    }];
    
    self.songPost = [[PFObject alloc] initWithClassName: @"SongPost"];
    //self.newSongPost[@"artistName"] = self.songInformation.songName;
    self.songPost[@"songName"] = self.songInformation.songName;
    self.songPost[@"albumName"] = self.songInformation.albumName;
    self.songPost[@"songGenre"] = self.songInformation.genreName;
    self.songPost[@"coverArt"] = self.songCoverArtDataFromImage;
    [self.songPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SONG SAVED SUCCESSFULLY!");
        }
        else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    NSLog(@"%@", self.songPost);
}

@end
