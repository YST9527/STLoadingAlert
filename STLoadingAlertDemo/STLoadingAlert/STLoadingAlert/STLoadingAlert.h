//
//  STLoadingIndicator.h
//  SunCarGuide
//
//  Created by jryghq on 15/11/18.
//  Copyright © 2015年 jryghq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STAlertView.h"
@class STIndicatorView;
@interface STLoadingAlert : NSObject
/**
 *  弹出一个提示框 只有一个点击按钮
 *
 *  @param title   标题
 *  @param content 内容
 *  @param okTitle 按钮标题
 *  @param block   按钮点击的回调
 *
 *  @return 提示框
 */
STAlertView * ShowOKSTAlertView(NSString *title, NSString *content, NSString *okTitle, STAlertViewButtonClickedBlock block);

/**
 *  弹出一个提示框
 *
 *  @param title       标题
 *  @param content     内容
 *  @param cancelTitle 取消按钮标题
 *  @param okTitle     确定按钮标题
 *  @param block       按钮点击的回调
 *
 *  @return 提示框
 */
STAlertView * ShowSTAlertView(NSString *title, NSString *content, NSString *cancelTitle, NSString *okTitle, STAlertViewButtonClickedBlock block);
/**
 *  显示加载动画 默认显示在keyWindow 显示的位置在window的中心
 */
void ShowLoading();

/**
 *  动画消失 默认从keyWindow上消失
 */
void ShowDismiss();

/**
 *  在窗口中间显示文字提示 默认显示在keyWindow 自动消失2.2s
 *
 *  @param title 需要显示的文字
 *
 *  @return 是否显示成功 若未成功 说明上一次的提示文字还未消失
 */
bool ShowSimpleAlert(NSString *title);

/**
 *  在指定的View上显示加载动画 显示的位置在View的中心
 *
 *  @param view 指定的View
 *
 *  @return 返回一个加载动画的View
 */
STIndicatorView * ShowLoadingInView(UIView *view);

/**
 *  将加载动画View从View上移除
 *
 *  @param indView 加载动画View
 */
void ShowIndicatorDismiss(STIndicatorView *indView);

/**
 *  在窗口的底部显示文字提示 自动消失2.2s
 *
 *  @param title 需要显示的文字
 *  @param view  显示在哪个View上
 *
 *  @return 是否显示成功 若未成功 说明上一次的提示文字还未消失
 */
//bool ShowSimpleAlertInView(NSString *title, UIView *view) DEPRECATED_ATTRIBUTE;

@end
