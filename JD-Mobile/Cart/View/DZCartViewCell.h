//
//  DZCartViewCell.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/22.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCartViewCell : UITableViewCell

/**
 *  文本框内容改变后的回调
 */
@property (nonatomic, copy) void (^callBack) (int currentNum);

@end
