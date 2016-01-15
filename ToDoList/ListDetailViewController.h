//
//  ListDetailViewControllerTableViewController.h
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckList.h"
#import "IconPickerViewController.h"

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property NSString *iconName;
@property (weak, nonatomic) id delegate;

@property CheckList* checklist;
- (IBAction)doneBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;

@end

@protocol ListDetailViewControllerDelegate <NSObject>

-(void)ListDetailViewControllerDidCancel:(ListDetailViewController *)controller;
-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(CheckList *)checklist;
-(void)ListDetailViewController:(ListDetailViewController *)controller didFinishEdittingChecklist:(CheckList *)checklist;

@end