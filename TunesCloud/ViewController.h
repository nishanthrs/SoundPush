//
//  ViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UILabel *loginText;
@property (strong, nonatomic) IBOutlet UILabel *signUpText;

- (IBAction)loginButtonPressed:(UIButton *)sender;
- (IBAction)signUpButtonPressed:(UIButton *)sender;

@end

