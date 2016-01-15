//
//  CheckListItem.m
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem

-(id) init:(NSString *)task {
  self.name = task;
  self.checked = NO;
  self.date = [[NSDate alloc] init];
  self.shouldRemind = NO;
  self.itemID = [DataModel nextChecklistItemID];
  return self;
}

-(instancetype)init {
  self = [super init];
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  _name = (NSString *)[aDecoder decodeObjectForKey:@"ItemName"];
  _checked = [aDecoder decodeBoolForKey:@"Checked"];
  _date = [aDecoder decodeObjectForKey:@"DueDate"];
  _shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
  _itemID = [aDecoder decodeIntegerForKey:@"ItemID"];
  self = [super init];
  return self;
}

-(void)shouldRemindNotification {
  
}

-(void)scheduleNotification {
  UILocalNotification *existingNotification = [self notificationForThisItem];
  if (existingNotification != nil) {
    [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
  }
  
  if (_shouldRemind && [_date compare:[NSDate date]] != NSOrderedAscending) {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = _date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = _name;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:[NSNumber numberWithInt:(_itemID)] forKey:@"ItemID"];
    localNotification.userInfo = dictionary;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    NSLog(@"Scheduled Notification");
  }
}

-(UILocalNotification *)notificationForThisItem {
  NSArray<UILocalNotification *> *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
  for (int i = 0; i < allNotifications.count; i++) {
    NSNumber *number = allNotifications[i].userInfo[@"ItemID"];
    if ([number integerValue] == _itemID) {
      return allNotifications[i];
    }
  }
  return nil;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_name forKey:@"ItemName"];
  [aCoder encodeBool:_checked forKey:@"Checked"];
  [aCoder encodeObject:_date forKey:@"DueDate"];
  [aCoder encodeBool:_shouldRemind forKey:@"ShouldRemind"];
  [aCoder encodeInteger:_itemID forKey:@"ItemID"];
}

@end
