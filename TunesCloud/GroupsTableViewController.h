//
//  GroupsTableViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/12/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicGroup.h"

@interface GroupsTableViewController : UITableViewController

@property (strong, nonatomic) MusicGroup *musicGroup;
@property (strong, nonatomic) NSMutableArray *musicGroups;

//- (IBAction)addMusicGroup:(UIBarButtonItem *)sender;

@end
