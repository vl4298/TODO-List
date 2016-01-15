//
//  DataModel.h
//  ToDoList
//
//  Created by Van Luu on 07/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckList.h"

@interface DataModel : NSObject

@property NSMutableArray *lists;
@property (nonatomic, getter=getIndex) NSInteger indexOfSelectedChecklist;

-(NSString *)documentDirectory;
-(NSString *)dataFilePath;
-(void)saveChecklists;
-(void)loadChecklists;
-(void)registerDetaults;

-(void)setIndexOfSelectedChecklist:(NSInteger)indexOfSelectedChecklist;
-(NSInteger)getIndex;

-(void)sortChecklists;

+(NSInteger)nextChecklistItemID;
@end
