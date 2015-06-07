//
//  SongInfo.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/11/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "SongInfo.h"

@implementation SongInfo

- (id) init {
    self = [self initWithSongInfo: nil andArtist: nil andAlbum: nil andGenre: nil andCoverArt: nil andPreviewURL: nil];
    return self;
}

- (id) initWithSongInfo:(NSString *)song andArtist:(NSString *)artist andAlbum:(NSString *)album andGenre:(NSString *)genre andCoverArt:(UIImageView *)coverArt andPreviewURL:(NSString *)previewURLString {
    self = [super init];
    
    self.songName = song;
    self.artistName = artist;
    self.albumName = album;
    self.genreName = genre;
    self.songCoverArt = coverArt;
    self.previewURL = previewURLString;
    
    return self;
}

@end
