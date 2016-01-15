//
//  AppDelegate.h
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllListViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property DataModel *dataModel;

-(void)saveData;

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

@end

