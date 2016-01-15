//
//  DetailItemTableViewController.m
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "DetailItemTableViewController.h"

@interface DetailItemTableViewController ()

@end

@implementation DetailItemTableViewController

@synthesize doneBtn;
@synthesize cancelBtn;
@synthesize itemNameTf;
@synthesize delegate;

-(instancetype)init {
  self = [super init];
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  _date = [[NSDate alloc] init];
  _datePickerVisible = NO;
  [itemNameTf becomeFirstResponder];
  
  doneBtn.enabled = NO;
  if (_item != nil) {
    doneBtn.enabled = YES;
    itemNameTf.text = _item.name;
    _date = _item.date;
    _shouldRemindSwich.on = _item.shouldRemind;
  }
  
  [self updateDueDateLabel];
}

-(void)updateDueDateLabel {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateStyle = NSDateFormatterMediumStyle;
  formatter.timeStyle = NSDateFormatterShortStyle;
  _dueDate.text = [formatter stringFromDate:_date];
}

-(void)showDatePicker {
  _datePickerVisible = YES;
  
  NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
  
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
  if (cell != nil) {
    cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;
  }
  NSArray<NSIndexPath *> *indexes = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:2 inSection:1], nil];
  
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
  //[self.tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
  [self.tableView endUpdates];
  
  [_datePicker setDate:_date animated:YES];
}

-(void)hideDatePicker {
  _datePickerVisible = NO;
  
  NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
  
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
  if (cell != nil) {
    cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;
  }
  NSArray<NSIndexPath *> *indexes = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:2 inSection:1], nil];
  
  [self.tableView beginUpdates];
  [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
  //[self.tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
  [self.tableView endUpdates];
}

- (IBAction)dateChanged:(id)sender {
  _date = _datePicker.date;
  [self updateDueDateLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

#pragma mark - Table view data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    return _datePickerCell;
  } else {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 1 && _datePickerVisible) {
    return 3;
  } else {
    return [super tableView:tableView numberOfRowsInSection:section];
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    return 217;
  } else {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [itemNameTf resignFirstResponder];
  
  if (indexPath.section == 1 && indexPath.row == 1) {
    if (_datePickerVisible) {
      [self hideDatePicker];
    } else {
      [self showDatePicker];
    }
  }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    indexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
  }
  
  return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
  NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
  
  doneBtn.enabled = str.length > 0;
  
  return YES;
}

- (IBAction)doneButtonPressed:(id)sender {
  if (_item != nil) {
    _item.name = itemNameTf.text;
    _item.shouldRemind = _shouldRemindSwich.on;
    _item.date = _date;
    [_item scheduleNotification];
    [delegate DetailItemTableViewController:self edittingItem:_item];
  } else {
    NSString *name = itemNameTf.text;
    CheckListItem *newItem = [[CheckListItem alloc] init:name];
    newItem.shouldRemind = _shouldRemindSwich.on;
    newItem.date = _date;
    [newItem scheduleNotification];
    [delegate DetailItemTableViewController:self newItem:newItem];
  }
}

- (IBAction)cancelButtonPressed:(id)sender {
  [delegate didPressCancel:self];
}

- (IBAction)shouldRemindToggle:(UISwitch *)sender {
  [itemNameTf resignFirstResponder];
  
  if (sender.on) {
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
  }
}

@end
