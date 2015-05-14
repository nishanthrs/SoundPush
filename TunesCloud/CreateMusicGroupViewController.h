//
//  CreateMusicGroupViewController.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicGroup.h"

@interface CreateMusicGroupViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *musicGroupNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *musicGenreNameTextField;

@end
