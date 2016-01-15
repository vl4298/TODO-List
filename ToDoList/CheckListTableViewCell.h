//
//  CheckListTableViewCell.h
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListItem.h"

@interface CheckListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *checkmarkLb;
@property CheckListItem *item;

-(void)configureItem;
-(void)configureCheckmark;
-(void)prepareForReuse;
@end
