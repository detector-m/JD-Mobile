//
//  DZAbstractDotView.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZAbstractDotView.h"

@implementation DZAbstractDotView

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changeActivityState:(BOOL)active {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

@end
