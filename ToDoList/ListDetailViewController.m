//
//  ListDetailViewControllerTableViewController.m
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  _doneBarBtn.enabled = NO;
  _iconName = @"Folder";
  if (_checklist != nil) {
    self.title = @"Edit Checklist";
    _textField.text = _checklist.name;
    _doneBarBtn.enabled = YES;
    _iconName = _checklist.iconName;
  }
  
  _iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - Textfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
  _doneBarBtn.enabled = str.length > 0;
  return true;
}


- (IBAction)doneBtnPressed:(id)sender {
  if (_checklist != nil) {
    _checklist.name = _textField.text;
    _checklist.iconName = _iconName;
    [_delegate ListDetailViewController:self didFinishEdittingChecklist:_checklist];
  } else {
    CheckList *newChecklist = [[CheckList alloc] init];
    newChecklist.name = _textField.text;
    newChecklist.iconName = _iconName;
    [_delegate ListDetailViewController:self didFinishAddingChecklist:newChecklist];
  }
}

- (IBAction)cancelBtnPressed:(id)sender {
  [_delegate ListDetailViewControllerDidCancel:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual:@"PickIcon"]) {
    IconPickerViewController *controller = segue.destinationViewController;
    controller.delegate = self;
  }
}

#pragma mark - icon picker delegate

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName {
  _iconName = iconName;
  _iconImageView.image = [UIImage imageNamed:iconName];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
