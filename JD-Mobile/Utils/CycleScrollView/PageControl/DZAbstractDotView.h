//
//  DZAbstractDotView.h
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZAbstractDotView : UIView

/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;

@end
