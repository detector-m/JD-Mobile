//
//  DZCustomSwitch.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/18.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZCustomSwitch.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_DURATION 0.5f

@interface DZCustomSwitch()
{
    CGFloat _minusTranslate;
    CGRect _leftRect;
    CGRect _middleRect;
    BOOL first;
    CGFloat _currentTranslationX;
}

@property(nonatomic,retain) UIView *customSwitch;
@property(nonatomic,retain) UIButton *onButton;
@property(nonatomic,retain) UIButton *offButton;

@end

@implementation DZCustomSwitch

@synthesize onImage = _onImage;
@synthesize offImage = _offImage;
@synthesize customSwitch = _customSwitch;
@synthesize onButton = _onButton;
@synthesize offButton = _offButton;
@synthesize arrange = _arrange;
@synthesize status = _status;

-(id)init {
    if (self == [super init]) {
        [self awakeFromNib];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

-(void)setStatus:(DZCustomSwitchStatus)status {
    if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
        if (self.status == DZCustomSwitchStatusOn) {
            if (status == DZCustomSwitchStatusOff) {
                [self moveButtonTranslation:_minusTranslate];
            }
        }else{
            if (status == DZCustomSwitchStatusOn) {
                [self moveButtonTranslation:0];
            }
        }
    }else{
        if (self.status == DZCustomSwitchStatusOn) {
            if (status == DZCustomSwitchStatusOff) {
                [self moveButtonTranslation:0];
            }
        }else{
            if (status == DZCustomSwitchStatusOn) {
                [self moveButtonTranslation:_minusTranslate];
            }
        }
    }
    [_customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    _status = status;
    
    if ([_delegate respondsToSelector:@selector(customSwitchSetStatus:)]) {
        [_delegate customSwitchSetStatus:_status];
    }
}

-(void)moveButtonTranslation:(CGFloat)translation {
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        _onButton.transform = CGAffineTransformMakeTranslation(translation, 0);
        _offButton.transform = CGAffineTransformMakeTranslation(translation, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(id)initWithOnImage:(UIImage *)onImage offImage:(UIImage *)offImage arrange:(DZCustomSwitchArrange)arrange{
    self.onImage = onImage;
    self.offImage = offImage;
    
    _customSwitch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _onImage.size.width, _onImage.size.height)];
    _customSwitch.backgroundColor = [UIColor redColor];
    
    _onButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_onButton setImage:onImage forState:UIControlStateNormal];
    
    _offButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_offButton setImage:offImage forState:UIControlStateNormal];
    _currentTranslationX = 0;
    
    if (_arrange == DZCustomSwitchArrangeONLeftOFFRight) {
        _onButton.frame = CGRectMake(0, 0, _onImage.size.width, _onImage.size.height);
        _offButton.frame = CGRectMake(_onImage.size.width - _onImage.size.height, 0, _offImage.size.width, _offImage.size.height);
    }else{
        _offButton.frame = CGRectMake(0, 0, _offImage.size.width, _offImage.size.height);
        _onButton.frame = CGRectMake(_onImage.size.width - _onImage.size.width, 0, _onImage.size.width, _onImage.size.height);
    }
    [_onButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_offButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_customSwitch addSubview:_onButton];
    [_customSwitch addSubview:_offButton];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged)];
    [_onButton addGestureRecognizer:panGesture];
    [_offButton addGestureRecognizer:panGesture];
    
    [self addSubview:_customSwitch];
    return self;
}

-(void)switchBtnDragged{
    XLog(@"switchBtnDragged");
}

-(void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"DZCustomSwitch" owner:self options:nil];
    for (UIView *view in nibs) {
        if ([view isKindOfClass:[UIView class]]) {
            _customSwitch = (UIView *)view;
            break;
        }
    }
    NSArray *subviews = [_customSwitch subviews];
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            if (btn.tag == 1){
                _onButton = btn;
            }else if (btn.tag == 2){
                _offButton = btn;
            }
        }
    }
}

-(void)switchBtnClicked {
    if (_status == DZCustomSwitchStatusOn) {
        [self setStatus:DZCustomSwitchStatusOff];
    }else{
        [self setStatus:DZCustomSwitchStatusOn];
    }
}

-(void)switchBtnDragged:(UIPanGestureRecognizer *)panGuester {
    CGFloat translation = [panGuester translationInView:panGuester.view].x;
    CGFloat moveTranslation = 0.0;
    moveTranslation = translation + _currentTranslationX;
    
    //NSLog(@"translation ：%f\n",translation);
    if (panGuester.state == UIGestureRecognizerStateChanged) {
        //往左边滑x<0 ,往右边滑x>0
        if (translation < 0) {
            BOOL move = NO;
            if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                if (_status == DZCustomSwitchStatusOff) {
                    move = YES;
                }
            }else{
                if (_status == DZCustomSwitchStatusOn) {
                    move = YES;
                }
            }
            if (move) {
                //移动范围不能超过可视范围
                if (fabs(moveTranslation) >= 0) {
                    [self moveButtonTranslation:0];
                }else{
                    [self moveButtonTranslation:moveTranslation];
                }
                
                //NSLog(@"向左移动：%f\n",moveTranslation);
            }
        }else if (translation > 0) {
            BOOL move = NO;
            if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                if (_status == DZCustomSwitchStatusOn) {
                    move = YES;
                }
            }else{
                if (_status == DZCustomSwitchStatusOff) {
                    move = YES;
                }
            }
            if (move) {
                //移动范围
                if (fabs(moveTranslation) > _minusTranslate) {
                    [self moveButtonTranslation:_minusTranslate];
                }else{
                    [self moveButtonTranslation:moveTranslation];
                }
                //NSLog(@"向右移动：%f\n",moveTranslation);
                
            }
        }
    }else if (panGuester.state == UIGestureRecognizerStateEnded){
        _currentTranslationX = panGuester.view.transform.tx;
        if (translation < 0) {
            if (fabs(moveTranslation) >= _minusTranslate / 3) {
                if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                    if (_status == DZCustomSwitchStatusOff) {
                        [self moveButtonTranslation:0];
                        [self setStatus:DZCustomSwitchStatusOn];
                    }
                }else{
                    if (_status == DZCustomSwitchStatusOn) {
                        [self moveButtonTranslation:0];
                        [self setStatus:DZCustomSwitchStatusOff];
                    }
                }
            }else{
                if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                    if (_status == DZCustomSwitchStatusOff) {
                        [self moveButtonTranslation:_minusTranslate];
                    }
                }else{
                    if (_status == DZCustomSwitchStatusOn) {
                        [self moveButtonTranslation:_minusTranslate];
                    }
                }
            }
        }else if (translation > 0) {
            if (fabs(moveTranslation) >= _minusTranslate/2) {
                if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                    if (_status == DZCustomSwitchStatusOn) {
                        [self moveButtonTranslation:_minusTranslate];
                        [self setStatus:DZCustomSwitchStatusOff];
                    }
                }else{
                    if (_status == DZCustomSwitchStatusOff) {
                        [self moveButtonTranslation:_minusTranslate];
                        [self setStatus:DZCustomSwitchStatusOn];
                    }
                }
            }else{
                if (_arrange == DZCustomSwitchArrangeOFFLeftONRight) {
                    if (_status == DZCustomSwitchStatusOn) {
                        [self moveButtonTranslation:0];
                    }
                }else{
                    if (_status == DZCustomSwitchStatusOff) {
                        [self moveButtonTranslation:0];
                    }
                }
            }
        }
    }
}

- (void)drawRect:(CGRect)rect {
    if (!first) {
        _customSwitch.backgroundColor = [UIColor clearColor];
        [_customSwitch setFrame:CGRectMake(_onImage.size.width/2, _onImage.size.height/2, _onImage.size.width, _onImage.size.height)];
        [_onButton setImage:_onImage forState:UIControlStateNormal];
        [_offButton setImage:_offImage forState:UIControlStateNormal];
        [_onButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_offButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _leftRect = CGRectMake(-(_onImage.size.width - _onImage.size.height), 0, _onImage.size.width, _onImage.size.height);
        _middleRect = CGRectMake(0, 0, _onImage.size.width, _onImage.size.height);
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_customSwitch.bounds
                                                            cornerRadius:_customSwitch.bounds.size.height / 2.0];
        maskLayer.path = maskPath.CGPath;
        _customSwitch.layer.mask = maskLayer;
        
        _minusTranslate = _onImage.size.width - _onImage.size.height;
        _currentTranslationX = 0;
        if (_arrange == DZCustomSwitchArrangeONLeftOFFRight) {
            _onButton.frame = _leftRect;
            _offButton.frame =  _middleRect;
            if (self.status == DZCustomSwitchStatusOn) {
                [self moveButtonTranslation:_minusTranslate];
            }else{
                [self moveButtonTranslation:0];
                [_customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            }
        }else{
            _offButton.frame = _leftRect;
            _onButton.frame =  _middleRect;
            if (self.status == DZCustomSwitchStatusOn) {
                [self moveButtonTranslation:0];
            }else{
                [self moveButtonTranslation:_minusTranslate];
                [_customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            }
        }
        
        UIPanGestureRecognizer *off_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged:)];
        UIPanGestureRecognizer *on_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged:)];
        [_onButton addGestureRecognizer:on_panGesture];
        [_offButton addGestureRecognizer:off_panGesture];
        
        [self addSubview:_customSwitch];
    }
    first = YES;
}

@end
