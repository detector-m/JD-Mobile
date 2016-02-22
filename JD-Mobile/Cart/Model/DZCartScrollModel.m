//
//  DZCartScrollModel.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/20.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCartScrollModel.h"

@implementation DZCartScrollModel

#pragma mark 带参数的构造函数
-(DZCartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image{
    if(self = [super init]){
        self.title = titleName;
        self.price = priceName;
        self.image = image;
    }
    return self;
}

#pragma mark 带参数的静态对象初始化方法
+(DZCartScrollModel *)initWithFirstTitle:(NSString *)titleName andPriceName:(NSString *)priceName andImageNumber:(NSString *)image{
    DZCartScrollModel *cartScrollModel = [[DZCartScrollModel alloc]initWithFirstTitle:titleName andPriceName:priceName andImageNumber:image];
    return cartScrollModel;
}

@end
