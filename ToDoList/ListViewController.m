//
//  ViewController.m
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = _checkList.name;
  if (_checkList.items == nil) {
    _checkList.items = [[NSMutableArray alloc] init];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _checkList.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CheckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemCell"];
  CheckListItem *item = [_checkList.items objectAtIndex:indexPath.row];
  cell.item = item;
  [cell configureItem];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  CheckListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  CheckListItem *item = [_checkList.items objectAtIndex:indexPath.row];
  item.checked = !item.checked;
  cell.item = item;
  [cell configureCheckmark];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier  isEqual: @"AddingItem"]) {
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    DetailItemTableViewController *controller = navigationController.viewControllers.firstObject;
    controller.delegate = self;
    
  } else if ([segue.identifier isEqual:@"EditItem"]) {
    NSIndexPath *index = [self.tableView indexPathForCell:(CheckListTableViewCell *)sender];
    CheckListItem *item = [_checkList.items objectAtIndex:index.row];
    
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    DetailItemTableViewController *controller = navigationController.viewControllers.firstObject;
    controller.delegate = self;
    controller.item = item;
  }
}


#pragma mark - DetailTableViewControllerDelegate
-(void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem newItem:(CheckListItem *)item {
  [_checkList.items insertObject:item atIndex:0];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didPressCancel:(DetailItemTableViewController *)detailitem {
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem edittingItem:(CheckListItem *)item {
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
