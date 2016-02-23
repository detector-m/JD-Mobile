//
//  DZCommoditySectionCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommoditySectionCell.h"

@implementation DZCommoditySectionCell

- (void)layoutSubviews {
    _serviceBtn.layer.borderWidth = 0.5;
    _serviceBtn.layer.cornerRadius = 5;
    _serviceBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _shopBtn.layer.borderWidth = 0.5;
    _shopBtn.layer.cornerRadius = 5;
    _shopBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
