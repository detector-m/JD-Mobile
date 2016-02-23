//
//  DZCommodityAddressCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZDetailsModel.h"

@interface DZCommodityAddressCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (void)showInfo:(DZDetailsModel *)model;

@end
