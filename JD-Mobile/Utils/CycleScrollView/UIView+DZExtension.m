//
//  UIView+DZExtension.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "UIView+DZExtension.h"

@implementation UIView (DZExtension)

- (CGFloat)sd_height {
    return self.frame.size.height;
}

- (void)setSd_height:(CGFloat)sd_height {
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}

- (CGFloat)sd_width {
    return self.frame.size.width;
}

- (void)setSd_width:(CGFloat)sd_width {
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}


- (CGFloat)sd_y {
    return self.frame.origin.y;
}

- (void)setSd_y:(CGFloat)sd_y {
    CGRect temp = self.frame;
    temp.origin.y = sd_y;
    self.frame = temp;
}

@end
