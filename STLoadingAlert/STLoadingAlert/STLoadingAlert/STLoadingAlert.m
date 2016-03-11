//
//  LoadingIndicator.m
//  SunCarGuide
//
//  Created by jryghq on 15/11/18.
//  Copyright © 2015年 jryghq. All rights reserved.
//

#import "STLoadingAlert.h"

@interface STIndicatorView : UIView{
    UIImageView *_loadingView;
    BOOL _loading;
    UIView *_showInView;
}
@property (nonatomic, assign) BOOL loading;
- (instancetype)initWithFrame:(CGRect)frame showInView:(UIView *)view;
@end

@implementation STIndicatorView

- (instancetype)initWithFrame:(CGRect)frame showInView:(UIView *)view {
    if (self = [super initWithFrame:frame]) {
        _showInView = view;
        _loading = NO;
        self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.userInteractionEnabled = NO;
        self.layer.cornerRadius = 13;
        self.layer.masksToBounds = YES;
        _loadingView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _loadingView.image = [[UIImage imageNamed:@"loading_imgBlue_78x78"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_loadingView setTintColor:__MAIN_COLOR];
        [self addSubview:_loadingView];
    }
    return self;
}

- (void)NetworkConnectFailedNotificaton:(NSNotification *)notification {
    self.loading = NO;
}

- (void)setLoading:(BOOL)loading {
    if (_loading == loading) {
        return ;
    }
    _loading = loading;
    if ([self.layer animationForKey:@"transform"]) {
        [self.layer removeAllAnimations];
    }
    if (loading) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        [_loadingView.layer addAnimation:animation forKey:@"transform"];
        [_showInView addSubview:self];
        
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.center = CGPointMake(CGRectGetWidth(_showInView.frame)/2, CGRectGetHeight(_showInView.frame)/4);
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.center = CGPointMake(CGRectGetWidth(_showInView.frame)/2, CGRectGetHeight(_showInView.frame)/2);
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [_loadingView.layer removeAllAnimations];
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            if (![self.layer animationForKey:@"transform"]) {
                [self removeFromSuperview];
            }
        }];
    }
}

- (void)dealloc {
//    __SHOW_FUNCTION;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@interface SimpleAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end

@implementation SimpleAlertView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 15;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.5;
        self.layer.masksToBounds = YES;
        CGRect rect = CGRectMake(CGRectGetWidth(frame)*0.1, 10, CGRectGetWidth(frame)*0.8, CGRectGetHeight(frame)-20);
        UILabel *label = [[UILabel alloc]initWithFrame:rect];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = MAX_CANON;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.text = title;
        label.alpha = 0;
        [self addSubview:label];
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        [UIView animateWithDuration:0.3 animations:^{
            label.alpha = 0.7;
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                label.alpha = 1;
                self.transform = CGAffineTransformIdentity;
            }];
        }];
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
        animation2.fromValue = @1;
        animation2.toValue = @0.2f;
        animation2.beginTime = CACurrentMediaTime()+2.8;
        animation2.duration = 0.5f;
        [self.layer addAnimation:animation2 forKey:nil];
        CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
        animation3.fromValue = @1;
        animation3.toValue = @0.2f;
        animation3.beginTime = CACurrentMediaTime()+2.8;
        animation3.duration = 0.5f;
        [self.layer addAnimation:animation3 forKey:nil];
    }
    return self;
}

- (void)dealloc {
//    __SHOW_FUNCTION;
}

@end

static SimpleAlertView *simpleView = nil;
static STIndicatorView *indView = nil;

@implementation STLoadingAlert

STAlertView * ShowOKSTAlertView(NSString *title, NSString *content, NSString *okTitle, STAlertViewButtonClickedBlock block) {
    return ShowSTAlertView(title, content, nil, okTitle, block);
}
STAlertView * ShowSTAlertView(NSString *title, NSString *content, NSString *cancelTitle, NSString *okTitle, STAlertViewButtonClickedBlock block) {
    STAlertView *alertView = [[STAlertView alloc]initWithTitle:title content:content cancelButton:cancelTitle okButton:okTitle];
    alertView.buttonClickedBlock = block;
    [alertView show];
    return alertView;
}

void ShowLoading() {
    if (indView == nil) {
        indView = [[STIndicatorView alloc]initWithFrame:CGRectMake(__DEVICE_WIDTH/2-30, __DEVICE_HEIGHT/2-30, 60, 60) showInView:__APP_WINDOW];
        indView.loading = YES;
    } else {
        indView.loading = YES;
    }
}

void ShowDismiss() {
    if (indView) {
        indView.loading = NO;
        indView = nil;
    }
}

STIndicatorView * ShowLoadingInView(UIView *view) {
    STIndicatorView *tempView = [[STIndicatorView alloc]initWithFrame:CGRectMake(CGRectGetWidth(view.frame)/2-30, CGRectGetHeight(view.frame)/2-60, 60, 60) showInView:view];
    tempView.loading = YES;
    view.userInteractionEnabled = NO;
    return tempView;
}

void ShowIndicatorDismiss(STIndicatorView *indView) {
    indView.superview.userInteractionEnabled = YES;
    indView.loading = NO;
}

bool ShowSimpleAlert(NSString *title) {
    if (title.length == 0) {
        return false;
    }
    return ShowSimpleAlertInView(title, __APP_WINDOW);
}

bool ShowSimpleAlertInView(NSString *title, UIView *view) {
    if (indView) {
        ShowDismiss();
    }
    if (simpleView) {
        return NO;
    }
    CGSize size = [title boundingRectWithSize:CGSizeMake(CGRectGetWidth(view.frame)*0.4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    size.width = CGRectGetWidth(view.frame)*0.5;
    size.height += 20;
    if (size.height < 60) {
        size.height = 60;
    }
    CGRect rect = CGRectMake((__DEVICE_WIDTH-size.width)/2, (__DEVICE_HEIGHT-size.height)/2, size.width, size.height);
    simpleView = [[SimpleAlertView alloc]initWithFrame:rect title:title];
    [view addSubview:simpleView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [simpleView removeFromSuperview];
        simpleView = nil;
    });
    return YES;
}

@end
