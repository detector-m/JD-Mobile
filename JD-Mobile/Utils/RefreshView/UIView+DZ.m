//
//  UIView+DZ.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "UIView+DZ.h"

@implementation UIView (DZ)

- (CGFloat)dz_height {
    return self.frame.size.height;
}

- (void)setDz_height:(CGFloat)dz_height {
    CGRect temp = self.frame;
    temp.size.height = dz_height;
    self.frame = temp;
}

- (CGFloat)dz_width {
    return self.frame.size.width;
}

- (void)setDz_width:(CGFloat)dz_width {
    CGRect temp = self.frame;
    temp.size.width = dz_width;
    self.frame = temp;
}

- (CGFloat)dz_y {
    return self.frame.origin.y;
}

- (void)setDz_y:(CGFloat)dz_y {
    CGRect temp = self.frame;
    temp.origin.y = dz_y;
    self.frame = temp;
}

@end
