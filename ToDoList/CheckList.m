//
//  CheckList.m
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "CheckList.h"

@implementation CheckList

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  
  if (self) {
    _name = [aDecoder decodeObjectForKey:@"Name"];
    _items = [aDecoder decodeObjectForKey:@"ChecklistItems"];
    _iconName = [aDecoder decodeObjectForKey:@"IconName"];
  }
  
  return self;
}

-(instancetype)init {
  _iconName = @"No Icon";
  self = [super init];
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_name forKey:@"Name"];
  [aCoder encodeObject:_items forKey:@"ChecklistItems"];
  [aCoder encodeObject:_iconName forKey:@"IconName"];
}

-(int)countUncheckedItems {
  int count = 0;
  for (int i = 0; i < _items.count; i++) {
    if ([_items[i] checked] == NO) {
      count += 1;
    }
  }
  return count;
}

-(NSComparisonResult)compare:(CheckList *)checklist {
  return [self.name compare:checklist.name];
}
@end
