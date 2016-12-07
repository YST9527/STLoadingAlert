//
//  STAlertView.m
//  SunCarGuide
//
//  Created by jryghq on 15/12/11.
//  Copyright © 2015年 jryghq. All rights reserved.
//

#import "STAlertView.h"
#define __ALERT_WIDTH (CGRectGetWidth([UIScreen mainScreen].bounds)/1.5)
#define __TOP_INTERVAL 1.5*__VERTICAL_INTERVAL
#define __HORIZONTAL_INTERVAL 10 //水平间距
#define __VERTICAL_INTERVAL 8 //垂直间距
#define __TITLE_FONT __SIZE_2 //标题
#define __CONTENT_FONT __SIZE_3 //内容
#define __BUTTON_HEIGHT 35
#ifndef __UTILITY

/**
 *  设备的高度
 */

#define __DEVICE_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 *  设备的宽度
 */

#define __DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

/**
 *  安全的调用block
 *
 *  @param block 调用的block
 *  @param param block回调时的参数
 *
 *  @return
 */

#define __SAFE_BLOCK(block,param,...) if(block != nil){block(param,##__VA_ARGS__);}

#endif
@implementation STAlertView {
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIView *_backgroundView;
    UIButton *_cancelBtn;
    UIButton *_okBtn;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content okButton:(NSString *)okTitle {
    return [self initWithTitle:title content:content cancelButton:nil okButton:okTitle];
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelButton:(NSString *)cancelTitle okButton:(NSString *)okTitle {
    
    if (self = [super initWithFrame:CGRectZero]) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __DEVICE_WIDTH, __DEVICE_HEIGHT)];
        _backgroundView.backgroundColor = [__COLOR_A colorWithAlphaComponent:0.7];
        _backgroundView.alpha = 0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.backgroundColor = __MAIN_BACK_COLOR;//[UIColor whiteColor];
        if (title.length != 0) {
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(__ALERT_WIDTH-__HORIZONTAL_INTERVAL*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:__TITLE_FONT]} context:nil].size;
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(__HORIZONTAL_INTERVAL, __TOP_INTERVAL, __ALERT_WIDTH-__HORIZONTAL_INTERVAL*2, titleSize.height)];
            _titleLabel.font = [UIFont boldSystemFontOfSize:__TITLE_FONT];
            _titleLabel.numberOfLines = 0;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.text = title;
            _titleLabel.textColor = __COLOR_A;
            [self addSubview:_titleLabel];
        }
        if (content.length != 0) {
            CGSize contentSize = [content boundingRectWithSize:CGSizeMake(__ALERT_WIDTH-__HORIZONTAL_INTERVAL*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:__CONTENT_FONT]} context:nil].size;
            CGFloat originY = (CGRectGetMaxY(_titleLabel.frame) == 0)?(__TOP_INTERVAL):(CGRectGetMaxY(_titleLabel.frame)+__VERTICAL_INTERVAL);
            _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(__HORIZONTAL_INTERVAL, originY, __ALERT_WIDTH-__HORIZONTAL_INTERVAL*2, contentSize.height)];
            _contentLabel.font = [UIFont systemFontOfSize:__CONTENT_FONT];
            _contentLabel.numberOfLines = 0;
            _contentLabel.textAlignment = NSTextAlignmentCenter;
            _contentLabel.text = content;
            _contentLabel.textColor = __COLOR_A;
            [self addSubview:_contentLabel];
        }
        
        NSUInteger index = 10;
        CGFloat originY = 0;
        if (_titleLabel) {
            originY = CGRectGetMaxY(_titleLabel.frame)+__VERTICAL_INTERVAL;
        }
        if (_contentLabel) {
            originY = CGRectGetMaxY(_contentLabel.frame)+__VERTICAL_INTERVAL;
        }
        
        if (cancelTitle) {
            _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _cancelBtn.tag = index++;
            _cancelBtn.frame = CGRectMake(__VERTICAL_INTERVAL, originY, (__ALERT_WIDTH-3*__VERTICAL_INTERVAL)/2, __BUTTON_HEIGHT);
            _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [_cancelBtn setTitleColor:__MAIN_COLOR forState:UIControlStateNormal];
            [_cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
            [_cancelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_cancelBtn setBackgroundImage:[self imageWithColor:__LINE_COLOR] forState:UIControlStateNormal];
            _cancelBtn.layer.cornerRadius = __BUTTON_HEIGHT/2;
            _cancelBtn.layer.masksToBounds = YES;
            [self addSubview:_cancelBtn];
        }
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.tag = index++;
        if (_cancelBtn) {
            _okBtn.frame = CGRectMake(CGRectGetMaxX(_cancelBtn.frame)+__VERTICAL_INTERVAL, originY, (__ALERT_WIDTH-3*__VERTICAL_INTERVAL)/2, __BUTTON_HEIGHT);
        }else {
            _okBtn.frame = CGRectMake(__VERTICAL_INTERVAL*4, originY, (__ALERT_WIDTH-8*__VERTICAL_INTERVAL), __BUTTON_HEIGHT);
        }
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_okBtn setTitleColor:__MAIN_BACK_COLOR forState:UIControlStateNormal];
        [_okBtn setTitle:okTitle forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:[self imageWithColor:__MAIN_COLOR] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.layer.cornerRadius = __BUTTON_HEIGHT/2;
        _okBtn.layer.masksToBounds = YES;
        [self addSubview:_okBtn];
        self.frame = CGRectMake(0, 0, __ALERT_WIDTH, CGRectGetMaxY(_okBtn.frame)+__VERTICAL_INTERVAL);
        self.center = CGPointMake(__DEVICE_WIDTH/2, __DEVICE_HEIGHT/2);
        self.transform = CGAffineTransformMakeScale(2, 2);
        self.alpha = 0;
    }
    return self;
}

- (void)show {
    [__APP_WINDOW endEditing:YES];
    __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusWillShow);
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.6;
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusDidShow);
    }];
}

- (void)buttonClicked:(UIButton *)button {
    __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusWillDismiss);
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_backgroundView removeFromSuperview];
        __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusDidDismiss);
    }];
    __SAFE_BLOCK(self.buttonClickedBlock, button.tag-10);
}

-(void)changeTitle:(NSString *)title{
    _titleLabel.text = title;
}

-(void)dismiss{
    __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusWillDismiss);
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_backgroundView removeFromSuperview];
        __SAFE_BLOCK(self.statusChangedBlock, STAlertViewStatusDidDismiss);
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)dealloc {
//    __SHOW_FUNCTION;
}

@end
