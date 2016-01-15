//
//  IconPickerViewController.h
//  ToDoList
//
//  Created by Van Luu on 08/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id delegate;
@property NSArray *icons;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end

@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;

@end
