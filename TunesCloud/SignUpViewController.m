//
//  SignUpViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (strong, nonatomic) UIAlertView *signUpSuccessAlertView;
@property (strong, nonatomic) UIAlertView *signUpFailureAlertView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextField.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.signUpSuccessAlertView = [[UIAlertView alloc] initWithTitle: @"Sign Up Complete!" message: @"You are now ready to start using TunesCloud!" delegate: nil cancelButtonTitle: @"Great! Let's start!" otherButtonTitles: nil, nil];
    self.signUpFailureAlertView = [[UIAlertView alloc] initWithTitle: @"Sign Up Unsuccessful!" message: @"Make sure your information is correct!" delegate: nil cancelButtonTitle: @"Try again" otherButtonTitles: nil, nil];
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
#pragma mark - Sign up and create new users

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signUpButtonPressed:(UIButton *)sender {
    PFUser *newUser = [[PFUser alloc] init];
    newUser.email = self.emailTextField.text;
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sign Up Successful!");
            [self.signUpSuccessAlertView show];
        }
        else {
            NSLog(@"There was an error signing up!");
            [self.signUpFailureAlertView show];
        }
    }];
}

@end
