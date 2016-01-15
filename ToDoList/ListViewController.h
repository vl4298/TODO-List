//
//  ViewController.h
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CheckListItem.h"
#import "DetailItemTableViewController.h"
#import "CheckListTableViewCell.h"
#import "CheckList.h"

@interface ListViewController : UITableViewController <DetailItemTableViewControllerDelegate>

@property CheckList *checkList;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem newItem:(CheckListItem *)item;
-(void)didPressCancel:(DetailItemTableViewController *)detailitem;
-(void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem edittingItem:(CheckListItem *)item;

@end

