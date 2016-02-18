//
//  DZUserDefaultsUtils.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZUserDefaultsUtils : NSObject

+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password;

+ (void)saveOwnID:(NSString*)userID userName:(NSString *)userName commodity:(int)commodity shop:(int)shop record:(int)record;

+ (int64_t)getOwnID;

+ (NSArray *)getOwnAccountAndPassword;

+ (void)clearCookie;

+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(void)print;

@end
