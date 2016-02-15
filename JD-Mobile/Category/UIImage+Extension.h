//
//  UIImage+Extension.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  针对ios7以上的系统适配新的图片资源
 *
 *  @param imageName 图片名称
 *
 *  @return 新的图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName;

/**
 *  伸缩变化图片
 *
 *  @param imageName 图片名称
 *
 *  @return 新的图片
 */
+ (UIImage*) resizableImageWithName:(NSString *)imageName;

/**
 *  实现图片的缩小或者放大
 *
 *  @param image 原图
 *  @param size  大小范围
 *
 *  @return 新的图片
 */
- (UIImage*) scaleImageWithSize:(CGSize)size;


@end
