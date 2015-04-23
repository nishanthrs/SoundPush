//
//  LoginViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () 

@property (strong, nonatomic) UIAlertView *incorrectLoginAlertView;
@property (strong, nonatomic) UIAlertView *incorrectFacebookLoginAlertView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *user = [PFUser currentUser];
    if (user) {
        [self performSegueWithIdentifier: @"appEntrySegue1" sender: self];
    }
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.incorrectLoginAlertView = [[UIAlertView alloc] initWithTitle: @"Login Unsuccessful!" message: @"Make sure all your info is correct!" delegate: nil cancelButtonTitle: @"Try Again" otherButtonTitles: nil, nil];
    self.incorrectFacebookLoginAlertView = [[UIAlertView alloc] initWithTitle: @"Facebook Login Unsuccessful!" message: @"There was an error logging in with Facebook" delegate: nil cancelButtonTitle: @"Try again" otherButtonTitles: nil, nil];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    
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

#pragma mark - Logging in user and testing login credentials

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [PFUser logInWithUsernameInBackground: self.usernameTextField.text password: self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            NSLog(@"Login Successful!");
        }
        else {
            [self.incorrectLoginAlertView show];
        }
    }];
     
}

//- (IBAction)facebookLoginButtonPressed:(UIButton *)sender {
//    NSArray *permissionsArray = @[@"user_about_me", @"user_location"];
//    
//    [PFFacebookUtils logInWithPermissions: permissionsArray block:^(PFUser *user, NSError *error) {
//       
//        if (!user) {
//            NSString *errorMessage = nil;
//            if (!error) {
//                NSLog(@"You cancelled the Facebook login");
//                errorMessage = @"You cancelled the Facebook login";
//            }
//            else {
//                NSLog(@"An error occured when signing in with Facebook");
//                errorMessage = [error localizedFailureReason];
//            }
//            [self.incorrectFacebookLoginAlertView show];
//        }
//        else {
//            if (user.isNew) {
//                NSLog(@"User with Facebook signed up AND logged in!");
//            }
//            else {
//                NSLog(@"User with Facebook logged in!");
//            }
//            //Perform segue
//        }
//    }];
//}

@end
