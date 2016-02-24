//
//  DZCommodityCellConfig.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/24.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

/**
 *   本类相当于将tableView中cell所需的基本信息存储下来，以便放到数组中管理
 *   改变不同类型cell的顺序、增删时，极为方便，只需改变ViewController中数据源数组即可，无需在多个tableView代理方法中逐个修改
 */

#import "DZCommodityCellConfig.h"

@implementation DZCommodityCellConfig

#pragma mark 便利构造器
+ (instancetype)cellConfigWithClassName:(NSString *)className title:(NSString *)title showInfoMethod:(SEL)showInfoMethod heightOfCell:(CGFloat)heightOfCell cellType:(BOOL) cellType {
    DZCommodityCellConfig *cellConfig = [DZCommodityCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    cellConfig.cellType = cellType;
    return cellConfig;
}

#pragma mark 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView dataModel:(id)dataModel cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class cellClass = NSClassFromString(self.className);

    // 重用cell
    NSString *cellID = self.className;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (self.cellType) {
            cell = [[NSBundle mainBundle] loadNibNamed: self.className owner:self options:nil][0];
            
        }else{
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
    }
    
    // 设置cell
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        [cell performSelector:self.showInfoMethod withObject:dataModel];
    }
    return cell;
}

@end
