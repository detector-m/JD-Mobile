//
//  DZCommodityAddressCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommodityAddressCell.h"

@implementation DZCommodityAddressCell

#pragma mark - 显示数据
- (void)showInfo:(DZDetailsModel *)model {
    self.addressLabel.text = model.detailsAddress;
    [self layoutSubviews];
}

@end
