//
//  DZTextField.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZTextField.h"

@interface DZTextField ()

@property (nonatomic, copy) NSString *password;
@property (nonatomic, weak) id beginEditingObserver;
@property (nonatomic, weak) id endEditingObserver;
@end

@implementation DZTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.password = @"";
    
    __weak DZTextField *weakSelf = self;
    
    self.beginEditingObserver = [[NSNotificationCenter defaultCenter]
                                 addObserverForName:UITextFieldTextDidBeginEditingNotification
                                 object:nil
                                 queue:nil
                                 usingBlock:^(NSNotification *note) {
                                     if (weakSelf == note.object && weakSelf.isSecureTextEntry) {
                                         weakSelf.text = @"";
                                         [weakSelf insertText:weakSelf.password];
                                     }
                                 }];
    
    self.endEditingObserver = [[NSNotificationCenter defaultCenter]
                               addObserverForName:UITextFieldTextDidEndEditingNotification
                               object:nil
                               queue:nil
                               usingBlock:^(NSNotification *note) {
                                   if (weakSelf == note.object) {
                                       weakSelf.password = weakSelf.text;
                                   }
                               }];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    BOOL isFirstResponder = self.isFirstResponder;
    [self resignFirstResponder];
    [super setSecureTextEntry:secureTextEntry];
    if (isFirstResponder) {
        [self becomeFirstResponder];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.beginEditingObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self.endEditingObserver];
}

@end
