//
//  DZBaseDao.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZBaseDao.h"

@implementation DZBaseDao

- (void)createTable:(NSString *)sql {
    FMDatabase *db = [[DZDatabase sharedInstance] openDatabase];
    if (![db executeUpdate:sql]) {
        XLog(@"Create table failed");
    }
    [db close];
}

@end
