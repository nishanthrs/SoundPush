//
//  CustomiTunesSearchTableViewCell.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/9/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "CustomiTunesSearchTableViewCell.h"

@implementation CustomiTunesSearchTableViewCell

@synthesize songNameLabel = _songNameLabel;
@synthesize songAlbumNameLabel = _songAlbumNameLabel;
@synthesize songGenreNameLabel = _songGenreNameLabel;
@synthesize songCoverArtImageView = _songCoverArtImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
