//
//  DZDatabase.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZDatabase.h"

@implementation DZDatabase

- (id)init {
    if (self = [super init]) {
        NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbpath = [docsdir stringByAppendingPathComponent:@"jdshop.db"];
        _database = [FMDatabase databaseWithPath:dbpath];
    }
    return self;
}

+ (DZDatabase *)sharedInstance {
    static DZDatabase *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (FMDatabase *)openDatabase {
    if ([_database open]) {
        return _database;
    }
    return nil;
}

- (void)removeAllData {
    NSDictionary *dic_sql = [self sqlForCreateTable];
    for (NSString *tableName in [dic_sql allKeys]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where 1 = 1",tableName];
        BOOL is_delete = [[[DZDatabase sharedInstance] openDatabase] executeUpdate:sql];
        XLog(@"%@",is_delete ? @"Delete all data success...":@"Delete all data failed...");
    }
}

- (BOOL)isTableExists:(NSString *)tableName {
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    
    FMResultSet *rs = [[self openDatabase] executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        if (count == 1) {
            XLog(@"%@ is existed.",tableName);
            return YES;
        }
        XLog(@"%@ is not exist.",tableName);
    }
    [rs close];
    
    return NO;
}

- (void)closeDB {
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_database close]) {
            _database = nil;
        }
    });
}

- (BOOL)deleteDatabase {
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"jd.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dbpath error:nil];
}

- (NSDictionary *)sqlForCreateTable {
    NSString *sqlFilePath = [[NSBundle mainBundle] pathForResource:@"sql" ofType:@"plist"];
    NSDictionary *dic_sql = [NSDictionary dictionaryWithContentsOfFile:sqlFilePath];
    return dic_sql;
}

@end
