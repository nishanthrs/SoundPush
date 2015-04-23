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

- (IBAction)loginButtonPressed:(UIButton *)sender;
- (IBAction)signUpButtonPressed:(UIButton *)sender;

@end

