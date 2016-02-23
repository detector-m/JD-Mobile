//
//  DZCommodityModel.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZCommodityModel : NSObject

/** 商品id*/
@property (nonatomic,assign) long long Id;
/** 图像*/
@property (nonatomic,copy) NSString *commodityImageUrl;
/** 名字*/
@property (nonatomic,copy) NSString *commodityName;
/** 价钱*/
@property (nonatomic,copy) NSString *commodityPrice;
/** 手机专享*/
@property (nonatomic,copy) NSString *commodityZX;
/** 评价*/
@property (nonatomic,copy) NSString *commodityPraise;
/** 人数*/
@property (nonatomic,copy) NSString *commodityPerson;


/** 根据字典初始化微博对象*/
-(DZCommodityModel *)initWithDictionary:(NSDictionary *)dic;

/** 初始化微博对象（静态方法）*/
+(DZCommodityModel *)commodityWithDictionary:(NSDictionary *)dic;

/** 好评*/
-(NSString *)praise;

@end
