//
//  SongPostTableViewCell.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 6/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongPostTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *songNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *userDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *songCoverArtImageView;

@property (strong, nonatomic) IBOutlet UIButton *playSongPreviewButton;
@property (strong, nonatomic) IBOutlet UIButton *playSpotifyTrackButton;
@property (strong, nonatomic) IBOutlet UIButton *likeSongButton;

@end
