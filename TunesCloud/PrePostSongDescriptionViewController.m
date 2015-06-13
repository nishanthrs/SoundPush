//
//  PrePostSongDescriptionViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 6/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "PrePostSongDescriptionViewController.h"

@interface PrePostSongDescriptionViewController ()

@end

@implementation PrePostSongDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userDescriptionTextField.delegate = self;
    
    PFQuery *query = [PFQuery queryWithClassName: @"SongPost"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"NO ERROR IN QUERYING OBJECT!");
            for (PFObject *object in objects) {
                self.sharedSong = [objects objectAtIndex: [objects count] - 1];
            }
        }
    }];
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)nextButtonPressed:(UIButton *)sender {
    self.sharedSong[@"userDescription"] = self.userDescriptionTextField.text;
    [self.sharedSong saveInBackground];
    NSLog(@"%@", self.userDescriptionTextField.text);
    NSLog(@"%@", self.sharedSong[@"userDescription"]);
    NSLog(@"%@", self.sharedSong[@"songName"]);
}

@end
