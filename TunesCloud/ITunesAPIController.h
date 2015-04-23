//
//  ITunesAPIController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "ITunesSearchResultsTableViewController.h"

@class ITunesAPIController;

@protocol ITunesAPIControllerProtocol;

@interface ITunesAPIController : NSObject

@property (retain, nonatomic) id<ITunesAPIControllerProtocol> delegate;
- (void) searchiTunesFor: (NSString *) searchTerm;

@end

@protocol ITunesAPIControllerProtocol <NSObject>

- (void) didReceiveITunesAPIResults : (NSDictionary *) results;

@end
