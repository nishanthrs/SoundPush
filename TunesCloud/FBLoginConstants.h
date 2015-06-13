//
//  FBLoginConstants.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 6/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//  Constants file used to create global constants that can be accessed conveniently in project

#import <Foundation/Foundation.h>

@interface FBLoginConstants : NSObject

#pragma mark - User Profile Constants

extern NSString *const kCCUserProfileKey; //extern creates global constant that can be accessed anywhere
extern NSString *const kCCUserProfileNameKey;
extern NSString *const kCCUserProfileFirstNameKey;
extern NSString *const kCCUserProfileEmailKey;
extern NSString *const kCCUserProfileLocationKey;

#pragma mark - User Photo Constants

extern NSString *const kCCPhotoClassKey;
extern NSString *const kCCPhotoUserKey;
extern NSString *const kCCPhotoPictureKey;
extern NSString *const kCCProfilePictureURL;

@end
