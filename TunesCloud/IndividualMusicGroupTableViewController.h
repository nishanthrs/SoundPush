//
//  IndividualMusicGroupTableViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//
//  Table View Controller only used for viewing songs, not adding them (adding/sharing songs done in ITunesSongInfoViewController

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface IndividualMusicGroupTableViewController : UITableViewController

@property (strong, nonatomic) NSString *musicGroupName;
@property (strong, nonatomic) PFObject *sharedSong;
@property (strong, nonatomic) NSArray *songPosts;
@property (strong, nonatomic) IBOutlet UIButton *playSongPreviewButton;

@property (strong, nonatomic) MPMoviePlayerController *audioPlayer;
@property (strong, nonatomic) MPMoviePlayerViewController *mediaPlayer;

- (IBAction)likeSongButtonPressed:(UIButton *)sender;
- (IBAction)spotifyLinkButtonPressed:(UIButton *)sender;

@end
