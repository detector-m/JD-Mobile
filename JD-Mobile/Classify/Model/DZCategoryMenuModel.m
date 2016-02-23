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
-(DZCategoryMenuModel *)initWithDictionary:(NSDictionary *)dic{
    if (self == [self init]) {
        self.Id = [dic[@"Id"] intValue];
        self.menuName = dic[@"menuName"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(DZCategoryMenuModel *)statusWithDictionary:(NSDictionary *)dic{
    DZCategoryMenuModel *categoryMenu = [[DZCategoryMenuModel alloc]initWithDictionary:dic];
    return categoryMenu;
}

@end
