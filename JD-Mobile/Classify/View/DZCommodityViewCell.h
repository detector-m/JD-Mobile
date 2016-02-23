//
//  DZCommodityViewCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCommodityViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *commodityImg;
@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *commodityPrice;
@property (strong, nonatomic) IBOutlet UIImageView *commodityZX;
@property (strong, nonatomic) IBOutlet UILabel *commodityPraise;

@end
