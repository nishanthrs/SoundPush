//
//  LoginViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, NSURLConnectionDelegate>

@property (nonatomic) BOOL facebookLogin;

@property (strong, nonatomic) NSMutableData *imageData;

@property (strong, nonatomic) IBOutlet UILabel *infoText1;
@property (strong, nonatomic) IBOutlet UILabel *infoText2;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UILabel *loginText;
@property (strong, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (strong, nonatomic) IBOutlet UILabel *facebookLoginText;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UILabel *signUpText;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (IBAction)loginButtonPressed:(UIButton *)sender;
- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender;
- (IBAction)facebookLoginButtonPressed:(UIButton *)sender;

@end
