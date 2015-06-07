//
//  MusicGroup.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 5/13/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MusicGroup : NSManagedObject

@property (nonatomic, retain) NSString * musicGroupName;
@property (nonatomic, retain) NSString * musicStyle;

- (id) init;

- (NSString *) getMusicGroupName;
- (NSString *) getMusicStyle;

@end
