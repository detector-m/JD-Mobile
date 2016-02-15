//
//  DZCollectionViewCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

@end
