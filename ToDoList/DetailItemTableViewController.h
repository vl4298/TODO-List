//
//  DetailItemTableViewController.h
//  ToDoList
//
//  Created by Van Luu on 05/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListItem.h"

@interface DetailItemTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UITextField *itemNameTf;
@property (weak, nonatomic) IBOutlet UISwitch *shouldRemindSwich;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UITableViewCell *datePickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property CheckListItem *item;
@property NSDate *date;
@property BOOL datePickerVisible;
@property (weak, nonatomic) id delegate;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)shouldRemindToggle:(UISwitch *)sender;
-(void)updateDueDateLabel;
-(void)showDatePicker;
-(void)hideDatePicker;
- (IBAction)dateChanged:(id)sender;

@end

@protocol DetailItemTableViewControllerDelegate <NSObject>

- (void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem newItem:(CheckListItem *)item;
-(void)DetailItemTableViewController:(DetailItemTableViewController *)detailItem edittingItem:(CheckListItem *)item;
-(void)didPressCancel: (DetailItemTableViewController *)detailitem;

@end
