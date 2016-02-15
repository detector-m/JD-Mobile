//
//  DZSearchBarView.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/16.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DZSearchBarViewDelegate;

@interface DZSearchBarView : UIView

/** 占位图*/
@property (nonatomic) NSString *placeholder;
/** 代理*/
@property (nonatomic, weak) id <DZSearchBarViewDelegate> delegate;

@end

@protocol DZSearchBarViewDelegate <NSObject>

@optional

- (void)searchBarAudioButtonClicked:(DZSearchBarView *)searchBarView;
- (void)searchBarSearchButtonClicked:(DZSearchBarView *)searchBarView;
@end

@interface RoundedView : UIView

@end
