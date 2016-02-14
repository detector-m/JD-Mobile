//
//  DZImage1ViewCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZImageName;
@interface DZImage1ViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *ImageView;

/** 根据数据模型来显示内容*/
- (void)showInfo:(DZImageName *)imageName;

@end
