//
//  AppDelegate.m
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(instancetype)init {
  _dataModel = [[DataModel alloc] init];
  self = [super init];
  return self;
}

-(void)saveData {
  [_dataModel saveChecklists];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  UINavigationController *navigationController = (UINavigationController *)_window.rootViewController;
  AllListViewController *controller = (AllListViewController *)navigationController.viewControllers.firstObject;
  controller.dataModel = _dataModel;
  
  UIUserNotificationType types = UIUserNotificationTypeBadge |
                                  UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
  
  UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
  [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  NSLog(@"terminate");
  [self saveData];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  //NSLog(@"didReceiveLocalNotification");
}

@end
