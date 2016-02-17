//
//  DZRefreshHeaderView.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZRefreshHeaderView.h"
#import "UIView+DZ.h"

@implementation DZRefreshHeaderView
{
    BOOL _hasLayoutedForManuallyRefreshing;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"下拉加载新数据...";
        self.stateIndicatorViewNormalTransformAngle = 0;
        self.stateIndicatorViewWillRefreshStateTransformAngle = M_PI;
        [self setRefreshState:DZRefreshViewStateNormal];
    }
    return self;
}

- (CGFloat)yOfCenterPoint {
    return - (self.dz_height * 0.5);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.center = CGPointMake(self.scrollView.dz_width * 0.5, [self yOfCenterPoint]);
    
    // 模拟手动刷新
    if (self.isManuallyRefreshing && !_hasLayoutedForManuallyRefreshing && self.scrollView.contentInset.top > 0) {
        self.activityIndicatorView.hidden = NO;
        
        // 模拟下拉操作7
        CGPoint temp = self.scrollView.contentOffset;
        temp.y -= self.dz_height * 2;
        self.scrollView.contentOffset = temp; // 触发准备刷新
        temp.y += self.dz_height;
        self.scrollView.contentOffset = temp; // 触发刷新
        
        _hasLayoutedForManuallyRefreshing = YES;
    } else {
        self.activityIndicatorView.hidden = !self.isManuallyRefreshing;
    }
}

- (void)beginRefreshing {
    self.isManuallyRefreshing = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:DZRefreshViewObservingkeyPath]) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = -self.dz_height - self.scrollView.contentInset.top;
    
    // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发SDRefreshViewStateRefreshing状态
    if (y >= criticalY && (self.refreshState == DZRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self setRefreshState:DZRefreshViewStateRefreshing];
    }
    
    // 触发SDRefreshViewStateWillRefresh状态
    if (y < criticalY && (DZRefreshViewStateNormal == self.refreshState)) {
        [self setRefreshState:DZRefreshViewStateWillRefresh];
    } else if (y >= criticalY && self.scrollView.isDragging) {
        self.refreshState = DZRefreshViewStateNormal;
    }
    
    if (self.refreshState == DZRefreshViewStateNormal && self.scrollView.dragging) {
        CGFloat scale = (-y - self.scrollView.contentInset.top) / self.dz_height;
        if (self.normalStateOperationBlock) {
            self.normalStateOperationBlock(self, scale);
        }
    }
}

@end
