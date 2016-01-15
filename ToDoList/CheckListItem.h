//
//  CheckListItem.h
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
#import <UIKit/UIKit.h>

@interface CheckListItem : NSObject <NSCoding>

@property NSString *name;
@property BOOL checked;

@property NSDate *date;
@property BOOL shouldRemind;
@property NSInteger itemID;

-(id) init: (NSString *)name;
-(void)encodeWithCoder:(NSCoder *)aCoder;
-(void)shouldRemindNotification;
-(void)scheduleNotification;
-(UILocalNotification *)notificationForThisItem;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
