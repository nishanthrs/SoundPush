//
//  PrePostSongDescriptionViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 6/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PrePostSongDescriptionViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userDescriptionTextField;
@property (strong, nonatomic) PFObject *sharedSong;

- (IBAction)nextButtonPressed:(UIButton *)sender;

@end
