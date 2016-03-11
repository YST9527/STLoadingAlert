# STLoadingAlert
一个很小巧的加载指示器和提示框

# 使用方法（STLoading）
ShowLoading();在window上显示加载指示
ShowDismiss();加载指示消失
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

# 使用方法（STSimpleAlert）

/**
*  在窗口中间显示文字提示 默认显示在keyWindow 自动消失3.0s
*
*  @param title 需要显示的文字
*
*  @return 是否显示成功 若未成功 说明上一次的提示文字还未消失
*/
bool ShowSimpleAlert(NSString *title);

# 使用方法（STAlertView）
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