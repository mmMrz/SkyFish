//
//  PersonPage.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "PersonPage.h"
#import "MyWeiboCell.h"

@implementation PersonPage{
    NSDictionary *personInfoDic;
    NSArray *weiboListAry;
    int page;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationItem addTitleViewWithTitle:@"个人主页"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedBackButtonWithTarget:self andSelector:@selector(navBack)]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_uid forKey:@"id"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",USER_GETUSERINFO] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        personInfoDic = responseDic[@"data"];
        [self setupView];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
    
    
    NSMutableDictionary *parameters2 = [[NSMutableDictionary alloc] init];
    [parameters2 setObject:_uid forKey:@"id"];
    [parameters2 setObject:@"20" forKey:@"count"];
    [parameters2 setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",WEIBO_GETLIST] andParameters:parameters2 complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        weiboListAry = responseDic[@"data"];
        [_tableView reloadData];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)setupView
{
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)personInfoDic[@"avatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [headView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
    [nameLbl setText:personInfoDic[@"name"]];
    [weiboCount setText:[personInfoDic[@"blogCount"] stringValue]];
    [attentionCount setText:personInfoDic[@"cared"]];
    [fansCount setText:personInfoDic[@"fans"]];
    
    [addressLbl setText:personInfoDic[@"address"]];
    [fishAgeLbl setText:personInfoDic[@"age"]];
    [skillLbl setText:personInfoDic[@"skill"]];
    [signLbl setText:personInfoDic[@"sign"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [weiboListAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyWeiboCellIdentifier = @"MyWeiboCell";
    MyWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:MyWeiboCellIdentifier];
    [cell setupViewWithDynamicInfo:weiboListAry[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
