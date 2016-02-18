//
//  DZRippleButtton.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^completion)(BOOL success);

@interface DZRippleButtton : UIView{
    
@private
    UIImageView *imageView;
    UILabel *title;
    UITapGestureRecognizer *gesture;
    SEL methodName;
    id superSender;
    UIColor *rippleColor;
    NSArray *rippleColors;
    BOOL isRippleOn;
}

@property (nonatomic, copy) completion block;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame andTarget:(SEL)action andID:(id)sender;

-(instancetype)initWithImage:(UIImage *)image andFrame:(CGRect)frame onCompletion:(completion)completionBlock;

-(void)setRippleEffectWithColor:(UIColor *)color;
-(void)setRippeEffectEnabled:(BOOL)setRippeEffectEnabled;

@end
