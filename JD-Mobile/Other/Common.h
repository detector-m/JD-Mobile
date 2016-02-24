//
//  Common.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#ifndef JD_Mobile_Common_h
#define JD_Mobile_Common_h

//SQL语句
#define USER_TABLE_SQL @"CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` VARCHAR(20) UNIQUE NOT NULL,`user_phone` VARCHAR(20) NOT NULL,`user_pwd` NOT NULL,`time` VARCHAR(20) NOT NULL,'user_name' VARCHAR(20) ,commodity,shop,record)"

#define _LolitaFunctions [DZLolitaFunctions sharedObject]

//公用颜色
#define DZCommonColor [UIColor colorWithRed:0.478 green:0.478 blue:0.478 alpha:1]
//颜色
#define DZColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//导航栏标题字体大小
#define DZNavigationFont [UIFont boldSystemFontOfSize:16]

//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//自定义日志输出
#ifdef DEBUG
//调试状态
#define XLog(...) NSLog(@"%s:%d\n %@ \n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
//发布状态
#define XLog(...)
#endif

#endif
