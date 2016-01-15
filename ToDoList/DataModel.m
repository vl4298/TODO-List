//
//  DataModel.m
//  ToDoList
//
//  Created by Van Luu on 07/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(instancetype)init {
  [self loadChecklists];
  [self registerDetaults];
  return self;
}

-(NSString *)documentDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  //NSLog(paths[0]);
  return paths[0];
}

-(NSString *)dataFilePath {
  return [[self documentDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists {
  NSMutableData *data = [NSMutableData new];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:_lists forKey:@"Checklists"];
  [archiver finishEncoding];
  [data writeToFile:[self dataFilePath] atomically:YES];
  //NSLog([self dataFilePath]);
}

-(void)loadChecklists {
  _lists = [[NSMutableArray alloc] init];
  NSString *path = [self dataFilePath];
  if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
      NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
      _lists = (NSMutableArray *)[unarchiver decodeObjectForKey:@"Checklists"];
      [unarchiver finishDecoding];
    }
  }
}

-(void)registerDetaults {
  
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  [dictionary setValue:[NSNumber numberWithInt:(-1)] forKey:@"ChecklistIndex"];
  [dictionary setValue:[NSNumber numberWithInt:(0)] forKey:@"ChecklistItemID"];
  [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void)setIndexOfSelectedChecklist:(NSInteger)indexOfSelectedChecklist {
  //NSLog(@"%d", indexOfSelectedChecklist);
  [[NSUserDefaults standardUserDefaults] setInteger:indexOfSelectedChecklist forKey:@"ChecklistIndex"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)getIndex {
  NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"ChecklistIndex"];
  NSInteger index = [number integerValue];
  return index;
}

-(void)sortChecklists {
  NSSortDescriptor *sortDescriptor;
  sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                               ascending:YES];
  NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
  [_lists sortUsingDescriptors:sortDescriptors];
}

+(NSInteger)nextChecklistItemID {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  NSInteger itemID =[userDefault integerForKey:@"ChecklistItemID"];
  [userDefault setInteger:(itemID + 1) forKey:@"ChecklistItemID"];
  [userDefault synchronize];
  return itemID;
}
@end
