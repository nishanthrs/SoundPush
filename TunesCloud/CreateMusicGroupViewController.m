//
//  CreateMusicGroupViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "CreateMusicGroupViewController.h"
#import "GroupsTableViewController.h"
#import "MusicGroup.h"

@interface CreateMusicGroupViewController ()

@end

@implementation CreateMusicGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.musicGroupNameTextField.delegate = self;
    self.musicGenreNameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper method for MusicGroup creation

- (MusicGroup *) createMusicGroupWithName : (NSString *) groupName andMusicStyle : (NSString *) musicStyle {
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    MusicGroup *newMusicGroup = [NSEntityDescription insertNewObjectForEntityForName: @"MusicGroup" inManagedObjectContext: context];
    newMusicGroup.musicGroupName = groupName;
    newMusicGroup.musicStyle = musicStyle;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error is %@", error);
    }
    
    return newMusicGroup;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass: [GroupsTableViewController class]]) {
        if ([segue.identifier isEqualToString: @"backToGroups"]) {
            MusicGroup *newMusicGroup = [self createMusicGroupWithName: self.musicGroupNameTextField.text andMusicStyle: self.musicGenreNameTextField.text];
            NSMutableArray *musicGroups = [[NSMutableArray alloc] init];
            [musicGroups addObject: newMusicGroup];
            GroupsTableViewController *nextViewController = segue.destinationViewController;
            nextViewController.musicGroups = musicGroups;
            NSLog(@"MUSIC GROUP IS %@", newMusicGroup.musicGroupName);
            NSLog(@"MUSIC STYLE IS %@", newMusicGroup.musicStyle);
        }
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
