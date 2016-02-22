//
//  DZScrollView.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/20.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DZScrollViewDataSource;
@protocol DZScrollViewDelegate;

@interface DZScrollView : UIView

@property (assign,nonatomic) NSInteger currentPage;
@property (assign,nonatomic) BOOL scrollEnabled;    //default is YES
@property (assign,nonatomic) BOOL cycleEnabled;     //是否可循环滚动，default is YES
@property (weak,nonatomic) id<DZScrollViewDataSource> dataSource;
@property (weak,nonatomic) id<DZScrollViewDelegate> delegate;

-(id)dequeueReusableView;//重用池中取出一个控件
-(void)reloadData;

@end

@protocol DZScrollViewDataSource<NSObject>

/*
 *	@brief	获取数据源，要注意的是，使用dequeueReusableView进行获取，如果返回为nil，则再进行创建，类似tableView早前的数据获取方式。
 *
 *	@param 	pageIndex 	第几页
 *
 *	@return	要展示的控件
 */
-(UIView *)viewForDZScrollView:(DZScrollView *)adScrollView atPage:(NSInteger)pageIndex;
-(NSUInteger)numberOfViewsForDZScrollView:(DZScrollView *)adScrollView;

@end

@protocol DZScrollViewDelegate<NSObject>

-(void)adScrollView:(DZScrollView *)adScrollView didClickedAtPage:(NSInteger)pageIndex;
-(void)adScrollView:(DZScrollView *)adScrollView didScrollToPage:(NSInteger)pageIndex;

@end
