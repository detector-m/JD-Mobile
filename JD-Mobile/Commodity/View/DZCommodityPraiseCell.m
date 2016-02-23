//
//  DZCommodityPraiseCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommodityPraiseCell.h"

@implementation DZCommodityPraiseCell

#pragma mark - 显示数据
- (void)showInfo:(DZDetailsModel *)model {
    self.praiseLabel.text = model.detailsPraise;
    self.personLabel.text = model.detailsPerson;
    [self layoutSubviews];
}

@end
