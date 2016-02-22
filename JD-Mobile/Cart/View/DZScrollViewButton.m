//
//  DZScrollViewButton.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/20.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZScrollViewButton.h"
#import "UIFont+Extend.h"

@implementation DZScrollViewButton

- (void)scrollViewButtonWith:(NSString *)price Title:(NSString *)title Image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 0, 100, 90)];
    imageView.image = image;
    imageView.layer.borderWidth = 0.5f;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.cornerRadius = 4.0f;
    [self addSubview:imageView];
    
    
    UILabel *titleLel = [[UILabel alloc]initWithFrame:CGRectMake(12.5,imageView.size.height, 100, 50)];
    titleLel.text = title;
    titleLel.numberOfLines = 2;
    titleLel.textColor = DZColor(100, 100, 100);
    titleLel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLel];
    
    UILabel *priceLel = [[UILabel alloc]initWithFrame:CGRectMake(12.5, imageView.size.height+40, 100, 25)];
    priceLel.text = price;
    priceLel.contentMode = NSTextAlignmentCenter;
    priceLel.textColor = DZColor(0, 0, 0);
    priceLel.font = [UIFont systemFontOfSize:15];
    [self addSubview:priceLel];
}

@end
