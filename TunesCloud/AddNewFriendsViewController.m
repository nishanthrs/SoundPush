//
//  AddNewFriendsViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/11/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "AddNewFriendsViewController.h"

@import AddressBook;

@interface AddNewFriendsViewController ()

@end

@implementation AddNewFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted) {
        UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [cantAddContactAlert show];
        NSLog(@"Denied access");
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        NSLog(@"Authorized");
    }
    else {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                [cantAddContactAlert show];
                NSLog(@"Just denied");
                return;
            }
            //5
            NSLog(@"Just authorized");
        });
        NSLog(@"Not determined");
    }
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

@end
