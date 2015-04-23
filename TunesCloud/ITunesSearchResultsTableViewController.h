//
//  ITunesSearchResultsTableViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ITunesAPIController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ITunesSearchResultsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, ITunesAPIControllerProtocol>

@property (strong, nonatomic) IBOutlet UISearchBar *songSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *songSearchTableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) ITunesAPIController *iTunesAPI;
@property (strong, nonatomic) MPMoviePlayerController *mediaPlayer;

- (void) didReceiveITunesAPIResults : (NSDictionary *)results;

@end
