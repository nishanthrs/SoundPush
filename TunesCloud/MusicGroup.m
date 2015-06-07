//
//  MusicGroup.m
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import "MusicGroup.h"

@implementation MusicGroup

@dynamic musicGroupName;
@dynamic musicStyle;

- (id) init {
    self = [super init];
    return self;
}

- (NSString *) getMusicGroupName {
    return self.musicGroupName;
}

- (NSString *) getMusicStyle {
    return self.musicStyle;
}

@end
