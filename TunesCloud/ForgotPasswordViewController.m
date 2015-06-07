//
//  ForgotPasswordViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/20/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import <Parse/Parse.h>

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailAddressTextField.delegate = self;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendEmailButtonPressed:(UIButton *)sender {
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey: @"email" equalTo: self.emailAddressTextField.text];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            PFUser *user = [objects firstObject];
            self.userPassword = user.password;
        }
    }];
    //Send email with account info here
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [NSString stringWithFormat: @"mailto:nishanth.salinamakki@gmail.com"]]];
    NSLog(@"Email Sent!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
