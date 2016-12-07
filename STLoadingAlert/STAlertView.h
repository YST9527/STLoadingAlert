//
//  STAlertView.h
//  SunCarGuide
//
//  Created by jryghq on 15/12/11.
//  Copyright © 2015年 jryghq. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef __UTILITY

#define __APP_WINDOW [UIApplication sharedApplication].keyWindow

/**
 *  安全的调用block
 *
 *  @param block 调用的block
 *  @param param block回调时的参数
 *
 *  @return
 */

#define __SAFE_BLOCK(block,param,...) if(block != nil){block(param,##__VA_ARGS__);}

/**
 *  设备的高度
 */

#define __DEVICE_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 *  设备的宽度
 */

#define __DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

/**
 *  系统主色调
 */
#define __MAIN_COLOR __HEX_STRING_COLOR(@"#fe6813")

/**
 *  系统主背景色
 */
#define __MAIN_BACK_COLOR __RGB_COLOR(240, 240, 240)

/**
 *  边线的颜色
 */
#define __LINE_COLOR __HEX_STRING_COLOR(@"#dcdcdc")

/**
 *  快速获取颜色
 *
 *  @param r 红
 *  @param g 绿
 *  @param b 蓝
 *  @param a 透明度
 *
 *  @return 颜色
 */
#define __RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:r*1.0/255 green:g*1.0/255 blue:b*1.0/255 alpha:a]
#define __RGB_COLOR(r,g,b) __RGBA_COLOR(r,g,b,1.0)

/**
 *  根据十六进制串获取颜色
 *
 *  @param hexStr 串
 *
 *  @return 颜色
 */
#define __HEX_STRING_COLOR(hexStr) ColorWithHexString(hexStr)

/*
 下面宏定义表示UI的尺寸和颜色
 */

#define __SIZE_1 18
#define __SIZE_2 16
#define __SIZE_3 15
#define __SIZE_4 12
#define __SIZE_5 11
#define __SIZE_6 10
#define __DETAIL_Color __HEX_STRING_COLOR(@"898989")
#define __COLOR_A __HEX_STRING_COLOR(@"#2f2f2f")
#define __COLOR_B __HEX_STRING_COLOR(@"#595959")
#define __COLOR_C __HEX_STRING_COLOR(@"#999999")
#define __COLOR_D __HEX_STRING_COLOR(@"#bcbcbc")

#define __1A_SIZE __SIZE_1
#define __1A_COLOR __COLOR_A

#define __2A_SIZE __SIZE_2
#define __2A_COLOR __COLOR_A
#define __2B_SIZE __SIZE_2
#define __2B_COLOR __COLOR_B

#define __3A_SIZE __SIZE_3
#define __3A_COLOR __COLOR_A
#define __3B_SIZE __SIZE_3
#define __3B_COLOR __COLOR_B
#define __3C_SIZE __SIZE_3
#define __3C_COLOR __COLOR_C

#define __4B_SIZE __SIZE_4
#define __4B_COLOR __COLOR_B
#define __4C_SIZE __SIZE_4
#define __4C_COLOR __COLOR_C
#define __4D_SIZE __SIZE_4
#define __4D_COLOR __COLOR_D

#define __5C_SIZE __SIZE_5
#define __5C_COLOR __COLOR_C

#define __6C_SIZE __SIZE_6
#define __6C_COLOR __COLOR_C
#define __KPlaceHolder_Color [UIColor lightGrayColor]//__HEX_STRING_COLOR(@"999999")
/*
 上面宏定义表示UI的尺寸和颜色
 */
/**
 *  将十六进制装换成UIColor
 *
 *  @param hexStr 十六进制字符串
 *
 *  @return UIColor
 */
static inline UIColor *ColorWithHexString(NSString *hexStr) {
    NSString *cString = [[NSString stringWithString:hexStr] uppercaseString];
    if ([cString length] < 6)
        return nil;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return nil;
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

#endif

/**
 *  提示框的几种状态
 */
typedef NS_ENUM(NSUInteger, STAlertViewStatus) {
    /**
     *  即将呈现
     */
    STAlertViewStatusWillShow,
    /**
     *  已经呈现
     */
    STAlertViewStatusDidShow,
    /**
     *  即将消失
     */
    STAlertViewStatusWillDismiss,
    /**
     *  已经消失
     */
    STAlertViewStatusDidDismiss
};

typedef void(^STAlertViewButtonClickedBlock)(NSUInteger buttonIndex);
typedef void(^STAlertViewStatusChangedBlock)(STAlertViewStatus status);

@interface STAlertView : UIView

@property (nonatomic, copy) STAlertViewButtonClickedBlock buttonClickedBlock;

@property (nonatomic, copy) STAlertViewStatusChangedBlock statusChangedBlock;

/**
 *  弹出一个提示框 只有一个点击按钮
 *
 *  @param title   标题
 *  @param content 内容
 *  @param okTitle 按钮标题
 *
 *  @return 提示框
 */

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content okButton:(NSString *)okTitle;

/**
 *  弹出一个提示框 有两个按钮
 *
 *  @param title       标题
 *  @param content     内容
 *  @param cancelTitle 取消按钮的标题
 *  @param okTitle     确定按钮的标题
 *
 *  @return 提示框
 */
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelButton:(NSString *)cancelTitle okButton:(NSString *)okTitle;

- (void)show;

-(void)changeTitle:(NSString *)title;

-(void)dismiss;

@end
