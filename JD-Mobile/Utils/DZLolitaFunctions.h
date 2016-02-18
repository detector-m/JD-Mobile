//
//  DZLolitaFunctions.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FollowType) {
    TypeFollow,
    TypeFollowing,
    TypeFollowed
};

@interface DZLolitaFunctions : NSObject{
    CGRect screenRect;
}

#pragma mark - Share Instance
+ (id)sharedObject;

#pragma mark - App Methods

-(UIColor *)colorWithR:(int)red g:(int)green b:(int)blue alpha:(float)alpha;
-(UIImageView *)leftViewForTextFieldWithImage:(NSString *)imageName;
-(UILabel *)leftViewForTextFieldWithTest:(NSString *)test;
-(BOOL)validateEmail:(NSString *)email;
-(UIView *)showLoadingViewWithText:(NSString *)strMessage inView:(UIView *)view;
-(void)hideLoadingView:(UIView *)loadingView;

-(NSString *)setTimeElapsedForDate:(NSDate *)starDate;


#pragma mark - Resizing image

-(UIImage *)resizeImageWithImage:(UIImage *)image toSize:(CGSize)newSize;

@end
