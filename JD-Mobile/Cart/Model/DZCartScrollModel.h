//
//  DZCartScrollModel.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/20.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZCartScrollModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *image;

/** 带参数的构造函数*/
-(DZCartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image;

/** 带参数的静态对象初始化方法*/
+(DZCartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image;

@end
