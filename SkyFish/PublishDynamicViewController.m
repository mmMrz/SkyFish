//
//  PublishDynamicViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "PublishDynamicViewController.h"

@interface PublishDynamicViewController ()

@end

@implementation PublishDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController loadTheme];
    [self.navigationItem addTitleViewWithTitle:@"发表渔获"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedCancelButtonWithTarget:self andSelector:@selector(close:)]];
}

- (void)close:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendDynamic:(UIButton *)sender {
    [ProgressHUD show:@"发表中"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:text_content.text forKey:@"content"];
    [parameters setObject:@"" forKey:@"images"];
    [parameters setObject:@"" forKey:@"address"];
    [parameters setObject:@"" forKey:@"lng"];
    [parameters setObject:@"" forKey:@"lat"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",WEIBO_ADD] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 0) {
            [ProgressHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧"]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([[textView.text trimSpace] isEqualToString:@""]) {
        [textView setText:@"说点什么吧"];
        [textView setTextColor:[UIColor blackColor]];
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
