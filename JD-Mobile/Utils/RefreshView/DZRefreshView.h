//
//  DZRefreshView.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    DZRefreshViewStateWillRefresh,
    DZRefreshViewStateRefreshing,
    DZRefreshViewStateNormal
} DZRefreshViewState;

typedef enum {
    DZRefreshViewStyleClassical,
    DZRefreshViewStyleCustom
} DZRefreshViewStyle;

@class DZRefreshView;

typedef void (^RefreshViewOperationBlock)(DZRefreshView *refreshView, CGFloat progress);


#define DZRefreshViewMethodIOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define DZRefreshViewObservingkeyPath @"contentOffset"
#define DZKNavigationBarHeight 64

#pragma mark - 配置

// 进入刷新状态时的提示文字
#define DZRefreshViewRefreshingStateText @"玩命加载新数据中..."
// 进入即将刷新状态时的提示文字
#define DZRefreshViewWillRefreshStateText @"松开立即加载新数据..."

@interface DZRefreshView : UIView

@property (nonatomic, copy) void(^beginRefreshingOperation)();
@property (nonatomic, weak) id beginRefreshingTarget;
@property (nonatomic, assign) SEL beginRefreshingAction;
@property (nonatomic, assign) BOOL isEffectedByNavigationController;

+ (instancetype)refreshView;
+ (instancetype)refreshViewWithStyle:(DZRefreshViewStyle)refreshViewStayle;

- (void)addToScrollView:(UIScrollView *)scrollView;
- (void)addToScrollView:(UIScrollView *)scrollView isEffectedByNavigationController:(BOOL)effectedByNavigationController;
- (void)addTarget:(id)target refreshAction:(SEL)action;
- (void)endRefreshing;

#pragma mark block
// 支持高度自定义操作的block，需要自定义刷新动画时使用,只需将对应操作加入对应的block即可
@property (nonatomic, copy) RefreshViewOperationBlock normalStateOperationBlock;
@property (nonatomic, copy) RefreshViewOperationBlock willRefreshStateOperationBlock;
@property (nonatomic, copy) RefreshViewOperationBlock refreshingStateOperationBlock;


#pragma mark - 以下视为此类的子类开放的接口

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) DZRefreshViewState refreshState;
@property (nonatomic, copy) NSString *textForNormalState;

/** 子类自定义位置使用*/
@property (nonatomic, assign) UIEdgeInsets scrollViewEdgeInsets;

@property (nonatomic, assign) CGFloat stateIndicatorViewNormalTransformAngle;

@property (nonatomic, assign) CGFloat stateIndicatorViewWillRefreshStateTransformAngle;

/** 记录原始contentEdgeInsets*/
@property (nonatomic, assign) UIEdgeInsets originalEdgeInsets;

/** 加载指示器*/
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, assign) BOOL isManuallyRefreshing;


- (UIEdgeInsets)syntheticalEdgeInsetsWithEdgeInsets:(UIEdgeInsets)edgeInsets;

@end
