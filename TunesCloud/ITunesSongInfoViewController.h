//
//  ITunesSongInfoViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/11/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongInfo.h"
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ITunesSongInfoViewController : UIViewController

@property (strong, nonatomic) SongInfo *songInformation;

@property (strong, nonatomic) IBOutlet UILabel *songNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *songGenreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *songCoverArtImageView;

- (IBAction)previewButtonPressed:(UIButton *)sender;
- (IBAction)shareButtonPressed:(UIButton *)sender;
- (IBAction)openSpotifyLinkButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) PFObject *songPost;
@property (strong, nonatomic) PFFile *songCoverArtDataFromImage;
@property (strong, nonatomic) NSData *songCoverArtData;
@property (strong, nonatomic) MPMoviePlayerController *audioPlayer;
@property (strong, nonatomic) MPMoviePlayerViewController *mediaPlayer;

@end
