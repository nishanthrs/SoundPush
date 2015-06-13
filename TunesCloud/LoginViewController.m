//
//  LoginViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "FBLoginConstants.h"

@interface LoginViewController () 

@property (strong, nonatomic) UIAlertView *incorrectLoginAlertView;
@property (strong, nonatomic) UIAlertView *incorrectFacebookLoginAlertView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.activityIndicator.hidden = YES;
    
    //PFUser *user = [PFUser currentUser];
    //Automatic login
//    if (user) {
//        [self performSegueWithIdentifier: @"appEntrySegue1" sender: self];
//    }
    
    UIImageView *background = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"musicappbackground.png"]];
    [self.view addSubview: background];
    
    [self.view addSubview: self.loginButton];
    [self.view addSubview: self.loginText];
    [self.view addSubview: self.facebookLoginButton];
    [self.view addSubview: self.facebookLoginText];
    [self.view addSubview: self.signUpButton];
    [self.view addSubview: self.signUpText];
    
    [self.view addSubview: self.infoText1];
    [self.view addSubview: self.infoText2];
    
    [self.view addSubview: self.usernameTextField];
    [self.view addSubview: self.passwordTextField];
    
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

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
    
}

- (IBAction)facebookLoginButtonPressed:(UIButton *)sender {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSLog(@"IS THE FUNCTION BEING CALLED?!");
    
    NSArray *permissionsArray = @[@"email", @"user_about_me", @"user_location", @"user_friends", @"user_photos"];
    
    [PFFacebookUtils logInWithPermissions: permissionsArray block:^(PFUser *user, NSError *error) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        if (!user) {
            if (!error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Login Error!" message: @"Facebook Login Cancelled!" delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil, nil];
                [alertView show];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Login Error!" message: [error description] delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil, nil];
                [alertView show];
            }
        }
        else {
            [self updateUserInformation];
            NSLog(@"CREATING USER!");
            [self performSegueWithIdentifier: @"fbSegue" sender: self];
        }
    }];
}

#pragma mark - Helper methods for logging in

- (void) updateUserInformation {
    FBRequest *request = [FBRequest requestForMe]; //Accesses current user information
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSLog(@"%@", result);
            
            NSDictionary *userDictionary = (NSDictionary *) result; //Cast result to NSDictionary
            
            NSLog(@"%@", userDictionary[@"name"]);
            
            //Create URL for photos
            NSString *userFacebookID = userDictionary[@"id"];
            NSURL *pictureURL = [NSURL URLWithString: [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture?type-large&return_ssl_resources=1", userFacebookID]]; //Creates url with user picture using user facebook id
            //UIImage *userPicture = [[UIImage alloc] initWithData: [[NSData alloc] initWithContentsOfURL: pictureURL]];
            
            PFObject *userInformation = [[PFObject alloc] initWithClassName: @"userInfo"];
            [userInformation saveInBackground];
            
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity: 10];
            if (userDictionary[@"name"]) {
                userProfile[kCCUserProfileNameKey] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[kCCUserProfileFirstNameKey] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]) {
                userProfile[kCCUserProfileLocationKey] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"email"]) {
                userProfile[kCCUserProfileEmailKey] = userDictionary[@"email"];
            }
            if ([pictureURL absoluteString]) { //Converts url into string
                userProfile[kCCProfilePictureURL] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject: userProfile forKey: kCCUserProfileKey];
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    NSLog(@"Error in saving user!");
                }
                else {
                    NSLog(@"User Saved!");
                }
            }];
            
            [self requestImage];
        }
        else {
            NSLog(@"Error in requesting for information: %@", [error localizedFailureReason]);
        }
    }];
    
}

- (void) uploadPFFileToParse: (UIImage *) image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    if (!imageData) {
        NSLog(@"Image Data Not Found!");
    }
    
    PFFile *photoFile = [PFFile fileWithData: imageData];
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Photo Upload Successful!");
            PFObject *photo = [PFObject objectWithClassName: kCCPhotoClassKey];
            [photo setObject: [PFUser currentUser] forKey: kCCPhotoUserKey];
            [photo setObject: photoFile forKey: kCCPhotoPictureKey];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Photo saved successfully!");
                }
                else {
                    NSLog(@"ERROR IN SAVING PHOTO!");
                    NSLog(@"%@", [error localizedFailureReason]);
                }
            }];
        }
        else {
            NSLog(@"ERROR IN UPLOADING PHOTO!");
        }
    }];
}

- (void) requestImage {
    PFQuery *query = [PFQuery queryWithClassName: kCCPhotoClassKey]; //Retrieves the photo from uploadPFFileToParse helper method
    [query whereKey: kCCPhotoUserKey equalTo: [PFUser currentUser]]; //Adds constraints to query of PFFiles
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number == 0) {
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];
            
            NSURL *profilePictureURL = [NSURL URLWithString: user[kCCUserProfileKey][kCCProfilePictureURL]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL: profilePictureURL cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 5.0f];
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest: urlRequest delegate:self];
            if (!urlConnection) {
                NSLog(@"FAILED TO DOWNLOAD PICTURE!");
            }
        }
    }];
}

- (void) connection: (NSURLConnection *) connection didReceiveData:(NSData *)data {
    [self.imageData appendData: data];
}

- (void) connectionDidFinishLoading: (NSURLConnection *) connection {
    UIImage *profileImage = [UIImage imageWithData: self.imageData];
    [self uploadPFFileToParse: profileImage];
}

//- (IBAction)facebookLoginButtonPressed:(UIButton *)sender {
//    NSArray *permissionsArray = @[@"user_about_me", @"user_location"];
//    NSLog(@"Confirmed Facebook Login!");
//    
//    [PFFacebookUtils logInWithPermissions: permissionsArray block:^(PFUser *user, NSError *error) {
//        if (user) {
//            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                if (!error) {
//                    [[PFUser currentUser] setObject: [result objectForKey: @"id"] forKey: @"fbId"];
//                    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                        if (succeeded) {
//                            NSLog(@"Facebook User Saved!");
//                        }
//                        else {
//                            NSLog(@"Facebook User Not Saved!");
//                        }
//                    }];
//                }
//                else {
//                    NSLog(@"THERE WAS AN ERROR WITH CONNECTING TO FACEBOOK!");
//                }
//            }];
//        }
//    }];
//}

@end
