//
//  AllListViewController.m
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "AllListViewController.h"

@interface AllListViewController ()

@end

@implementation AllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  //NSLog(@"view did appear");
  self.navigationController.delegate = self;
  
  NSInteger index = [_dataModel getIndex];
  
  if (index > 0 && index < _dataModel.lists.count) {
    CheckList *checklist = _dataModel.lists[(int)index];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
  }
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataModel.lists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
  cell.textLabel.text = [[_dataModel.lists objectAtIndex:indexPath.row] name];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d remaining", [[_dataModel.lists objectAtIndex: indexPath.row] countUncheckedItems]];
  cell.imageView.image = [UIImage imageNamed:[[_dataModel.lists objectAtIndex:indexPath.row] iconName]];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  _dataModel.indexOfSelectedChecklist = indexPath.row;
  
  CheckList *checklist = (CheckList *)[_dataModel.lists objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  CheckList *checkList = [_dataModel.lists objectAtIndex:indexPath.row];
  UINavigationController *navigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ListDetailNavigationController"];
  ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
  controller.delegate = self;
  controller.checklist = checkList;
  
  [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual:@"AddNewChecklist"]) {
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.viewControllers.firstObject;
    controller.delegate = self;
  } else if ([segue.identifier isEqual:@"ShowChecklist"]) {
    ListViewController *controller = (ListViewController *)segue.destinationViewController;
    
    controller.checkList = (CheckList *)sender;
  }
}

#pragma mark - List Detail View Controller Delegate

-(void)ListDetailViewControllerDidCancel:(ListDetailViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishEdittingChecklist:(CheckList *)checklist {
  [_dataModel sortChecklists];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(CheckList *)checklist {
  [_dataModel.lists addObject:checklist];
  [_dataModel sortChecklists];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - navigation controller delegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if ([viewController isKindOfClass:self.class]) {
    [_dataModel setIndexOfSelectedChecklist:(NSInteger)-1];
  }
}

@end
