//
//  DZCommodityModel.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCommodityModel.h"

@implementation DZCommodityModel

#pragma mark 根据字典初始化商品对象
-(DZCommodityModel *)initWithDictionary:(NSDictionary *)dict {
    if(self = [super init]){
        self.Id = [dict[@"Id"] longLongValue];
        self.commodityImageUrl = dict[@"commodityImageUrl"];
        self.commodityName = dict[@"commodityName"];
        self.commodityPrice = dict[@"commodityPrice"];
        self.commodityZX = dict[@"commodityZX"];
        self.commodityPraise = dict[@"commodityPraise"];
        self.commodityPerson = dict[@"commodityPerson"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(DZCommodityModel *)commodityWithDictionary:(NSDictionary *)dict{
    DZCommodityModel *commodity = [[DZCommodityModel alloc]initWithDictionary:dict];
    return commodity;
}

#pragma mark 好评
-(NSString *)praise{
    return [NSString stringWithFormat:@"好评%@ %@人",_commodityPraise,_commodityPerson];
}

@end
