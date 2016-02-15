//
//  NSData+DZDataCache.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "NSData+DZDataCache.h"
#import <CommonCrypto/CommonDigest.h>

#define kDZMaxCacheFileAmount 100

@implementation NSData (DZDataCache)

+ (NSString *)cachePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"DZDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)creatMD5StringWithString:(NSString *)string {
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    [hash lowercaseString];
    return hash;
}

+ (NSString *)creatDataPathWithString:(NSString *)string {
    NSString *path = [NSData cachePath];
    path = [path stringByAppendingPathComponent:[self creatMD5StringWithString:string]];
    return path;
}

- (void)saveDataCacheWithIdentifier:(NSString *)identifier {
    NSString *path = [NSData creatDataPathWithString:identifier];
    [self writeToFile:path atomically:YES];
}

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier {
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self cachePath] error:nil];
        if (contents.count >= kDZMaxCacheFileAmount) {
            [manager removeItemAtPath:[self cachePath] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self creatDataPathWithString:identifier];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (void)clearCache {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[self cachePath] error:nil];
}

@end
