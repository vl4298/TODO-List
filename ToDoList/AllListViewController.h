//
//  AllListViewController.h
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckList.h"
#import "ListViewController.h"
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>
@property DataModel *dataModel;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(CheckList *)checklist;
-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishEdittingChecklist:(CheckList *)checklist;
-(void)ListDetailViewControllerDidCancel:(ListDetailViewController *)controller;

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
