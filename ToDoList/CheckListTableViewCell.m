//
//  CheckListTableViewCell.m
//  ToDoList
//
//  Created by Van Luu on 06/01/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

#import "CheckListTableViewCell.h"

@implementation CheckListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureItem {
  if (_item != nil) {
    _nameLb.text = [NSString stringWithFormat:@"%@", _item.name];
    
    [self configureCheckmark];
  }
}

-(void)configureCheckmark {
  if (!_item.checked) {
    _checkmarkLb.text = @"";
  } else {
    _checkmarkLb.text = @"✓";
  }
}

-(void)prepareForReuse {
  _item = nil;
}

@end
