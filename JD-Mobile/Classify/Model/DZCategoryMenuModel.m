//
//  DZCategoryMenuModel.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCategoryMenuModel.h"

@implementation DZCategoryMenuModel

#pragma mark 根据字典初始化对象
-(DZCategoryMenuModel *)initWithDictionary:(NSDictionary *)dict{
    if (self == [self init]) {
        self.Id = [dict[@"Id"] intValue];
        self.menuName = dict[@"menuName"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(DZCategoryMenuModel *)statusWithDictionary:(NSDictionary *)dict{
    DZCategoryMenuModel *categoryMenu = [[DZCategoryMenuModel alloc]initWithDictionary:dict];
    return categoryMenu;
}

@end
