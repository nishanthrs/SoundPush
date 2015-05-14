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

@interface IndividualMusicGroupTableViewController : UITableViewController

@property (strong, nonatomic) PFObject *sharedSong;
@property (strong, nonatomic) NSMutableArray *songPosts;

@end
