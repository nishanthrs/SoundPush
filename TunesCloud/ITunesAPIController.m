//
//  ITunesAPIController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesAPIController.h"
#import "ITunesSearchResultsTableViewController.h"

@implementation ITunesAPIController

@synthesize delegate;

#pragma mark - iTunes API

- (void) searchiTunesFor: (NSString *) searchTerm {
    
    NSString *iTunesSearchItem = [searchTerm stringByReplacingOccurrencesOfString: @" " withString: @"+" options: NSCaseInsensitiveSearch range: NSMakeRange(0, [searchTerm length])];
    NSString *escapedSearchItem = [iTunesSearchItem stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    if (escapedSearchItem) {
        NSString *urlPath = [@"http://itunes.apple.com/search?term=" stringByAppendingString: escapedSearchItem];//Sugar"; //Format search url based on search input
        NSURL *url = [NSURL URLWithString: urlPath]; //Create url based on string
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionTask *task = [session dataTaskWithURL: url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            //NSLog(@"Task Completed!");
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            NSError *err = nil;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &err];
            //NSLog(@"Please print out results: %@", jsonResult);
            if (err != nil) {
                NSLog(@"JSON Error");
                NSLog(@"%@", [error localizedDescription]);
            }
            //NSArray *searchResults = jsonResult[@"results"];//Get JSON results
            //NSArray *searchResults = [jsonResult valueForKey: @"results"];
            //NSLog(@"The search results are %@", searchResults);
            //NSLog(@"The number of results is %lu", (unsigned long)[searchResults count]);
//            if (!self.delegate) {
//                NSLog(@"Delegate not called");
//            }
            [self.delegate didReceiveITunesAPIResults : jsonResult];
//            dispatch_async(dispatch_get_main_queue(), ^{ //Task occurs in background, so must jump back to main thread to update UI
//                self.tableData = searchResults;
//                [self.songSearchTableView reloadData]; //Go to UI and update with data
//            });
            
        }];
        [task resume];
    }
}

@end
