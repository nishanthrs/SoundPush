//
//  UserProfileViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/27/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "UserProfileViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "FBLoginConstants.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void) setSong {
    [self performSegueWithIdentifier: @"setFavoriteSongSegue" sender: nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Set Song" style: UIBarButtonItemStylePlain target: self action: @selector(setSong)];
    
    UIImageView *background = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"musicappbackground.png"]];
    [self.view addSubview: background];
    [self.view addSubview: self.usernameLabel];
    [self.view addSubview: self.favoriteSongLabel];
    
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *) result;
            self.usernameLabel.text = userDictionary[@"name"];
        }
    }];
    
    //Query retrieves profile picture retrieved in LoginViewController
    PFQuery *photoQuery = [[PFQuery alloc] initWithClassName: kCCPhotoClassKey];
    [photoQuery whereKey: kCCPhotoUserKey equalTo: [PFUser currentUser]];
    
    [photoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0) {
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) { //inBackground methods retrieve information asynchronously
                self.userProfilePictureImageView.image = [UIImage imageWithData: data];
            }];
        }
    }];
    
    [self.view addSubview: self.userProfilePictureImageView];
    
    PFQuery *favoriteSongQuery = [[PFQuery alloc] initWithClassName: @"FavoriteSong"];
    [favoriteSongQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.favoriteSongLabel.text = objects[[objects count] - 1][@"songName"];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *data = objects[[objects count] - 1][@"coverArtData"];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.songCoverArtImageView.image = [UIImage imageWithData: data];
                    });
                }
            });
            //self.songCoverArtImageView.image = [UIImage imageWithData: objects[[objects count] - 1][@"coverArtData"]];
            NSLog(@"Setting favorite song successful!");
        }
        else {
            NSLog(@"THE ERROR DESCRIPTION: %@", [error localizedDescription]);
            NSLog(@"ERROR IN SETTING FAVORITE SONG!");
        }
    }];
    
    [self.view addSubview: self.songCoverArtImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playSongButtonPressed:(UIButton *)sender {
    PFQuery *favoriteSongQuery = [[PFQuery alloc] initWithClassName: @"FavoriteSong"];
    [favoriteSongQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.favoriteSongLabel.text = objects[[objects count] - 1][@"songName"];
            self.songCoverArtImageView.image = [UIImage imageWithData: objects[[objects count] - 1][@"coverArtData"]];
            self.audioPlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString: objects[[objects count] - 1][@"previewURLString"]]];
            [self.audioPlayer prepareToPlay];
            NSLog(@"Setting favorite song successful!");
        }
        else {
            NSLog(@"ERROR IN SETTING FAVORITE SONG!");
        }
    }];
}
@end
