//
//  DZImage3ViewCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZImage3ViewCell.h"
#import "DZImageName.h"

@implementation DZImage3ViewCell

#pragma mark - 懒加载
// 注意，使用懒加载时，调用属性最好用self.,因为第一次调用一定要用self.
- (UIImageView *)imageView {
    if (!_ImageView) {
        _ImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_ImageView];
    }
    return _ImageView;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, 500);
}

#pragma mark - 显示数据
- (void)showInfo:(DZImageName *)imageName {
    self.imageView.image = [UIImage imageNamed:imageName.imageName1];
    
    [self layoutSubviews];
}

@end
