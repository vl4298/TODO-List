//
//  IconPickerViewController.m
//  ToDoList
//
//  Created by Van Luu on 08/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  _icons = @[@"No Icon", @"Appointments", @"Birthdays", @"Chores", @"Drinks", @"Folder", @"Groceries", @"Inbox", @"Photos", @"Trips"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view controller delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _icons.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
  
  NSString *iconName = _icons[indexPath.row];
  cell.textLabel.text = iconName;
  cell.imageView.image = [UIImage imageNamed:iconName];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *iconName = _icons[indexPath.row];
  [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
