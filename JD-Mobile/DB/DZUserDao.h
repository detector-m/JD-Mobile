//
//  DZUserDao.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZBaseDao.h"

@class DZUserModel;
@interface DZUserDao : DZBaseDao

- (BOOL)insertUser:(DZUserModel *)entity;

- (DZUserModel*)selectLogin:(NSString*)phone :(NSString*)pwd;

- (DZUserModel*)selectAdd:(NSString*)userId ;

@end
