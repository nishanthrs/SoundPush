//
//  ForgotPasswordViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/20/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ForgotPasswordViewController : UIViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MFMailComposeViewController *mail;
@property (strong, nonatomic) NSString *userPassword;

@property (strong, nonatomic) IBOutlet UITextField *emailAddressTextField;

- (IBAction)sendEmailButtonPressed:(UIButton *)sender;

@end
