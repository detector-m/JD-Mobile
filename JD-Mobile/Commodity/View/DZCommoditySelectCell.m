//
//  DZCommoditySelectCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommoditySelectCell.h"

@implementation DZCommoditySelectCell

#pragma mark - 显示数据
- (void)showInfo:(DZDetailsModel *)model {
    self.selectLabel.text = model.detailsSelect;
    [self layoutSubviews];
}

@end
