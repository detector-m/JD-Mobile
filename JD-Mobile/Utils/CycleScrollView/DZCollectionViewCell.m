//
//  DZCollectionViewCell.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/15.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCollectionViewCell.h"
#import "UIView+DZExtension.h"

@implementation DZCollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor {
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor {
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont {
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self addSubview:imageView];
}

- (void)setupTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat titleLabelW = self.sd_width;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.sd_height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _titleLabel.hidden = !_titleLabel.text;
}

@end
