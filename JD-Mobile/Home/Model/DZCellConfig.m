//
//  DZCellConfig.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCellConfig.h"

@implementation DZCellConfig

#pragma mark 便利构造器
/**
 * @brief 便利构造器
 *
 * @param className:类名
 * @param title:标题，可用做cell直观的区分
 * @param showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
 * @param heightOfCell:此类cell的高度
 *
 *
 */
+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell {
    DZCellConfig *cellConfig = [[DZCellConfig alloc] init];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    
    return cellConfig;
}

#pragma mark 生成cell
/** 根据cellConfig生成cell，重用ID为cell类名*/
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel {
    Class cellClass = NSClassFromString(self.className);
    
    
    // 重用cell
    NSString *cellID = self.className;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    // 设置cell
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        [cell performSelector:self.showInfoMethod withObject:dataModel];
    }
    
    return cell;
}

@end
