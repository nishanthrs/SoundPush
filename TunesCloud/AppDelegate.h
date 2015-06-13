//
//  AppDelegate.h
//  TunesCloud
//
//  Created by Nishanth Salinamakki on 4/7/15.
//  Copyright (c) 2015 Nishanth Salinamakki. All rights reserved.
//
// Errors to Fix:
// 1. Figure out how to execute introspection with NSManagedObjectSubclass (MusicGroup name is null) to make sure that song is being added in only one group
// 2. Incorporate Spotify link to redirect to song Spotify link (sign up and post to Stack Overflow).
// 3. Implement 'forgot password' feature using Parse API.
// 4. Load images asynchronously (multithreading)!
// 5. Fix loginViewController; don't allow segue unless login is valid!!

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

