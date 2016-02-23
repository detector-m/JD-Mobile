//
//  DZDetailsModel.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZDetailsModel : NSObject

/** 商品id*/
@property (nonatomic,assign) long long Id;
/** 商品名称*/
@property (nonatomic, strong) NSString *detailsName;
/** 商品活动*/
@property (nonatomic, strong) NSString *detailsActivity;
/** 商品价钱*/
@property (nonatomic, strong) NSString *detailsPrice;
/** 专项图片*/
@property (nonatomic, strong) NSString *detailsImgZX;
/** 专项文字*/
@property (nonatomic, strong) NSString *detailsTxtZX;
/** 选择*/
@property (nonatomic, strong) NSString *detailsSelect;
/** 地址*/
@property (nonatomic, strong) NSString *detailsAddress;
/** 评价*/
@property (nonatomic, strong) NSString *detailsPraise;
/** 人数*/
@property (nonatomic, strong) NSString *detailsPerson;

@end
