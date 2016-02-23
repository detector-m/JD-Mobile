//
//  DZCommoditySelectCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZDetailsModel.h"

@interface DZCommoditySelectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

/** 根据数据模型来显示内容*/
- (void)showInfo:(DZDetailsModel *)model;

@end
