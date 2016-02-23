//
//  DZMultilevelTableViewCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZMultilevelTableViewCell.h"

@implementation DZMultilevelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setZero{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins = UIEdgeInsetsZero;
    }
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset = UIEdgeInsetsZero;
    }    
}

@end
