//
//  CustomiTunesSearchTableViewCell.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomiTunesSearchTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *songCoverArtImageView;
@property (strong, nonatomic) IBOutlet UILabel *songNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *songAlbumNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *songGenreNameLabel;

@end
