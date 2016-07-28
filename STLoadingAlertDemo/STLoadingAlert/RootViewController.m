//
//  RootViewController.m
//  STLoadingAlert
//
//  Created by jryghq on 16/3/6.
//  Copyright © 2016年 jryghq. All rights reserved.
//

#import "RootViewController.h"
#import "STLoadingAlert/STLoadingAlert.h"
@interface RootViewController ()
@property (nonatomic, assign) BOOL loading;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)AlertBtnClicked:(UIButton *)sender {
    ShowSTAlertView(@"提示框", @"作者尹思同，谢谢大家！", @"谢谢", @"谢谢", ^(NSUInteger buttonIndex) {
        
    });
}
- (IBAction)LoadingBtnClicked:(id)sender {
    self.loading = !self.loading;
    if (self.loading) {
        ShowLoading();
    }else {
        ShowDismiss();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
