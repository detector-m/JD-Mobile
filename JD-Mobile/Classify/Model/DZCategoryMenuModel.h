//
//  DZCategoryMenuModel.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZCategoryMenuModel : NSObject

/** 菜单ID*/
@property(assign,nonatomic) int Id;
/** 菜单名*/
@property(copy,nonatomic) NSString *menuName;
/** 菜单图片名*/
@property(copy,nonatomic) NSString *urlName;


/** 下一级菜单*/
@property(strong,nonatomic) NSArray * nextArray;

/** 菜单层数*/
@property(assign,nonatomic) NSInteger meunNumber;

@property(assign,nonatomic) float offsetScorller;


/** 根据字典初始化对象*/
-(DZCategoryMenuModel *)initWithDictionary:(NSDictionary *)dic;

/** 初始化对象（静态方法）*/
+(DZCategoryMenuModel *)statusWithDictionary:(NSDictionary *)dic;

@end
