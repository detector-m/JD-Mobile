//
//  DZUserDao.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZUserDao.h"
#import "DZUserModel.h"

@implementation DZUserDao

- (BOOL)insertUser:(DZUserModel *)entity{
    [self createTable:USER_TABLE_SQL];
    
    FMResultSet* rs = [[[DZDatabase sharedInstance] openDatabase]executeQuery:@"SELECT count(*) as countNum FROM user WHERE user_phone=?" withArgumentsInArray:@[entity.userPhone]];
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        
        XLog(@"%i",(int)count);
        if (count > 0) {
            return NO;
        }
    }
    
    NSString *sql = @"INSERT INTO user (user_id,user_phone,user_pwd,time,user_name,commodity,shop,record) VALUES(?,?,?,?,?,?,?,?)";
    BOOL is_insert = [[[DZDatabase sharedInstance] openDatabase] executeUpdate:sql
                                                        withArgumentsInArray:@[entity.userId,
                                                                               entity.userPhone,
                                                                               entity.userPwd,
                                                                               entity.time,
                                                                               entity.userName,
                                                                               entity.commodity,
                                                                               entity.shop,
                                                                               entity.record
                                                                               ]
                      ];
    
    return  is_insert;
}

- (DZUserModel*)selectLogin:(NSString*)phone :(NSString*)pwd{
    FMResultSet* rs = [[[DZDatabase sharedInstance] openDatabase]executeQuery:@"SELECT * FROM user WHERE user_phone=? and user_pwd=?" withArgumentsInArray:@[phone,pwd]];
    DZUserModel * um = [[DZUserModel alloc]init];
    if ([rs next]) {
        um.userId = [rs stringForColumn:@"user_id"];
        um.userName = [rs stringForColumn:@"user_name"];
        um.time = [rs stringForColumn:@"time"];
        um.commodity = [NSNumber numberWithInteger:[rs intForColumn:@"commodity"]];
        um.shop = [NSNumber numberWithInteger:[rs intForColumn:@"shop"]];
        um.record = [NSNumber numberWithInteger:[rs intForColumn:@"record"]];
    }else{
        um = nil;
    }
    return um;
}

- (DZUserModel*)selectAdd:(NSString*)userId{
    FMResultSet* rs =[[[DZDatabase sharedInstance] openDatabase]executeQuery:@"SELECT * FROM user WHERE user_id=?" withArgumentsInArray:@[userId]];
    DZUserModel * um = [[DZUserModel alloc]init];
    if ([rs next]) {
        um.userName = [rs stringForColumn:@"user_name"];
        um.commodity = [NSNumber numberWithInteger:[rs intForColumn:@"commodity"]];
        um.shop = [NSNumber numberWithInteger:[rs intForColumn:@"shop"]];
        um.record = [NSNumber numberWithInteger:[rs intForColumn:@"record"]];
        
    }else{
        um = nil;
    }
    return um;
}

@end
