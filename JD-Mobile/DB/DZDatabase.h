//
//  DZDatabase.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

/**
 *  Database operate delegate
 */
@protocol DZDatabaseDelegate <NSObject>

@optional
- (NSMutableArray *)queryAll;
- (NSMutableArray *)queryAllOrderByName;
- (NSMutableArray *)queryAllOrderByTime;
- (void)closeDB;
- (BOOL)removeAll;

@required
- (void)createTable:(NSString *)sql;

@end


@interface DZDatabase : NSObject

@property(nonatomic,strong) FMDatabase *database;

/** 管理类单例*/
+ (DZDatabase *)sharedInstance;

/** 获取数据库连接对象*/
- (FMDatabase *)openDatabase;

/** 删除所有表的数据*/
- (void)removeAllData;

/** 关闭数据库*/
- (void)closeDB;

/** 删除数据库文件*/
- (BOOL)deleteDatabase;

/** 判断指定表是否存在*/
- (BOOL)isTableExists:(NSString *)tableName;

@end
