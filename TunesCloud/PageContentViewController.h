//
//  PageContentViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;

@property (strong, nonatomic) IBOutlet UIImageView *pageBackgroundImage;
@property (strong, nonatomic) IBOutlet UILabel *pageDescriptionLabel;

@property (strong, nonatomic) NSString *pageDescriptionText;
@property (strong, nonatomic) NSString *imageFile;

@end
