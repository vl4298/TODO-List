//
//  CheckList.h
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckListItem.h"

@interface CheckList : NSObject <NSCoding>

@property NSString *name;
@property NSMutableArray* items;
@property NSString* iconName;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

-(int)countUncheckedItems;
-(NSComparisonResult)compare: (CheckList *)checklist;
@end
