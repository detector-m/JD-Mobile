//
//  DZCustomSwitch.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DZCustomSwitchStatus)
{
    DZCustomSwitchStatusOn = 0,//开启
    DZCustomSwitchStatusOff = 1//关闭
};

typedef NS_ENUM(NSUInteger, DZCustomSwitchArrange)
{
    DZCustomSwitchArrangeONLeftOFFRight = 0,//左边是开启,右边是关闭，默认
    DZCustomSwitchArrangeOFFLeftONRight = 1//左边是关闭，右边是开启
};

@protocol DZCustomSwitchDelegate <NSObject>

-(void)customSwitchSetStatus:(DZCustomSwitchStatus)status;
@end

@interface DZCustomSwitch : UIControl
{
    UIImage *_onImage;
    UIImage *_offImage;
    id<DZCustomSwitchDelegate> _delegate;
    DZCustomSwitchArrange _arrange;
    
}

@property(nonatomic,retain) UIImage *onImage;
@property(nonatomic,retain) UIImage *offImage;
@property(nonatomic,retain) IBOutlet id<DZCustomSwitchDelegate> delegate;
@property(nonatomic) DZCustomSwitchArrange arrange;
@property(nonatomic) DZCustomSwitchStatus status;

@end
