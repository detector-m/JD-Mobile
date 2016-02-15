//
//  NSData+DZDataCache.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DZDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

@end
