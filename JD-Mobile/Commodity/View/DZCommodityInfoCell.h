//
//  DZCommodityInfoCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZDetailsModel.h"
#import "TYAttributedLabel.h"
#import "TYLinkTextStorage.h"

#define kHeightCommodityInfo 180

@interface DZCommodityInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) TYAttributedLabel *activityLabel;
/** 商品价钱*/
@property (nonatomic, strong) UILabel *priceyLabel;
/** 专项图片*/
@property (nonatomic, strong) UIImageView *imgZXImageview;
/** 专项文字*/
@property (nonatomic, strong) UILabel *txtZXLabel;

/** 根据数据模型来显示内容*/
- (void)showInfo:(DZDetailsModel *)model;

@end
