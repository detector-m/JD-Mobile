//
//  DZMasonyUtil.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZMasonyUtil : NSObject

/** 居中显示*/
+ (void)centerView:(UIView *)view size:(CGSize)size;

/** 含有边距*/
+ (void)view:(UIView *)view EdgeInset:(UIEdgeInsets)edgeInsets;

/** view的数目大于两个*/
+ (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth;
@end
