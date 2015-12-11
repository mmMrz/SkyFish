//
//  LoginViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "LoginViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface LoginViewController (){
    
    __weak IBOutlet UITextField *userAccount_tf;
    __weak IBOutlet UITextField *userPassword_tf;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self login:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton *)sender {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:userAccount_tf.text forKey:@"tel"];
    [parameters setObject:userPassword_tf.text forKey:@"password"];
    [parameters setObject:@"1" forKey:@"type"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",USER_LOGIN] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        
        [[GlobalData sharedInstance].currentUserInfo setUid:responseDic[@"data"][@"id"]];
        [[GlobalData sharedInstance].currentUserInfo setUserInfoWithDic:responseDic[@"data"]];
        
        [self requestQINIUToken];
        
        //登录融云服务器
        [[RCIM sharedRCIM] connectWithToken:responseDic[@"data"][@"rongToken"] success:^(NSString *userId) {
            NSLog(@"登录融云服务器成功");
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登录融云服务器失败:%ld",status);
        } tokenIncorrect:^{
            NSLog(@"融云TOKEN失效");
        }];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)requestQINIUToken
{
    [CSLoadData requestOfInfomationWithURI:COMMON_QINIUTOKEN andParameters:nil complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
        NSString *qiniuToken = responseDic[@"data"][@"token"];
        [[GlobalData sharedInstance].currentUserInfo setQiniuToken:qiniuToken];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
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
