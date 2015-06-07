//
//  SongInfo.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/11/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SongInfo : NSObject

@property (strong, nonatomic) NSString *songName;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *genreName;
@property (strong, nonatomic) UIImageView *songCoverArt;
@property (strong, nonatomic) NSString *previewURL;

- (id) initWithSongInfo : (NSString *) song andArtist : (NSString *) artist andAlbum : (NSString *) album andGenre : (NSString *) genre andCoverArt : (UIImageView *) coverArt andPreviewURL : (NSString *) previewURLString;

@end
