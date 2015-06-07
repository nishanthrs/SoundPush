//
//  LoginViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) BOOL facebookLogin;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (IBAction)loginButtonPressed:(UIButton *)sender;
- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender;
- (IBAction)facebookLoginButtonPressed:(UIButton *)sender;

@end
