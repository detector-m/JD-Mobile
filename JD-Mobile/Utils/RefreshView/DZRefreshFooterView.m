//
//  DZRefreshFooterView.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZRefreshFooterView.h"
#import "UIView+DZ.h"

@implementation DZRefreshFooterView
{
    CGFloat _originalScrollViewContentHeight;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"上拉加载新数据...";
        self.stateIndicatorViewNormalTransformAngle = M_PI;
        self.stateIndicatorViewWillRefreshStateTransformAngle = 0;
        [self setRefreshState:DZRefreshViewStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.activityIndicatorView.hidden = YES;
    _originalScrollViewContentHeight = self.scrollView.contentSize.height;
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(0, 0, self.dz_height, 0);
    self.center = CGPointMake(self.scrollView.dz_width * 0.5, self.scrollView.contentSize.height + self.dz_height * 0.5 + self.scrollView.contentInset.bottom);
    
    self.hidden = [self shouldHide];
}

- (BOOL)shouldHide {
    if (self.isEffectedByNavigationController) {
        return (self.scrollView.bounds.size.height - DZKNavigationBarHeight + self.scrollView.contentInset.bottom > self.dz_y);
    }
    return (self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom > self.dz_y);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:DZRefreshViewObservingkeyPath]) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    
    // 只有在 y>0 以及 scrollview的高度不为0 时才判断
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发SDRefreshViewStateRefreshing状态
    if (y < (self.scrollView.contentSize.height - self.scrollView.dz_height + self.dz_height + self.scrollView.contentInset.bottom) && (self.refreshState == DZRefreshViewStateWillRefresh)) {
        [self setRefreshState:DZRefreshViewStateRefreshing];
    }
    
    // 触发SDRefreshViewStateWillRefresh状态
    if (y > (self.scrollView.contentSize.height - self.scrollView.dz_height + self.dz_height + self.scrollView.contentInset.bottom) && (DZRefreshViewStateNormal == self.refreshState)) {
        if (self.hidden) return;
        [self setRefreshState:DZRefreshViewStateWillRefresh];
    }
    
    // 如果scrollView内容有增减，重新调整refreshFooter位置
    if (self.scrollView.contentSize.height != _originalScrollViewContentHeight) {
        [self layoutSubviews];
    }
}

@end
