//
//  SelectGroupTableViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/14/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MusicGroup.h"
#import "SongInfo.h"

@interface SelectGroupTableViewController : UITableViewController

@property (strong, nonatomic) MusicGroup *musicGroup;
@property (strong, nonatomic) NSArray *musicGroups;
@property (strong, nonatomic) PFObject *sharedSong;

@end
