//
//  UserProfileViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/27/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *userProfilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *favoriteSongLabel;
@property (strong, nonatomic) IBOutlet UIImageView *songCoverArtImageView;

@end
