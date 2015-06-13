//
//  ViewController.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"
#import <Parse/Parse.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface ViewController () <UIPageViewControllerDataSource>

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PFObject *testObject = [PFObject objectWithClassName: @"TestObjectCategory"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"Parse Object Saving Successful!");
//        }
//        else {
//            NSLog(@"UNSUCCESSFUL!");
//        }
//    }];
    
//    PFQuery *pushQuery = [PFInstallation query];
//    [pushQuery whereKey: @"deviceType" equalTo: @"ios"];
//    [PFPush sendPushMessageToQueryInBackground: pushQuery withMessage: @"Finally works!" block:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"Yes, it works!");
//        }
//        else {
//            NSLog(@"There was a freaking error");
//        }
//    }];
    
    UIImageView *background = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"musicappbackground.png"]];
    [self.view addSubview: background];
    
    [self.view addSubview: self.loginButton];
    [self.view addSubview: self.signUpButton];
    [self.view addSubview: self.loginText];
    [self.view addSubview: self.signUpText];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: nil];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 4) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    NSArray *pageImages = @[@"Sign In Page", @"Newfeed Page.png", @"page3.png", @"page4.png"];
    pageContentViewController.imageFile = pageImages[index];
    
    NSArray *pageDescriptions = @[@"Welcome to TunesCloud!", @"Share music with your friends!", @"Create groups and post new songs!", @"Upvote and share your favorite songs!"];
    pageContentViewController.pageDescriptionText = pageDescriptions[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 4) {
        return [self viewControllerAtIndex: 0];
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
}

- (IBAction)signUpButtonPressed:(UIButton *)sender {
    
}

@end
