//
//  PersonPage.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "PersonPage.h"
#import "MyWeiboCell.h"
#import "EditMyInfoViewController.h"

@implementation PersonPage{
    NSDictionary *personInfoDic;
    NSArray *weiboListAry;
    int page;
    __weak IBOutlet UIImageView *bgImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    [self setTitle:@"个人主页"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedBackButtonWithTarget:self andSelector:@selector(navBack)]];
    [self.navigationItem addRightBarButtonItem:[UIBarButtonItem themedBarButtonWithTarget:self andSelector:@selector(editMyInfo:) andButtonTitle:@"编辑"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
}

- (void)editMyInfo:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EditMyInfoViewController *editMyInfoVC = [story instantiateViewControllerWithIdentifier:@"EditMyInfoViewController"];
    [self.navigationController pushViewController:editMyInfoVC animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的热闹"]];
    [imageView setFrame:CGRectMake(12, 10, 20, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 20)];
    [label setFont:[UIFont systemFontOfSize:13.0]];
    [label setTextColor:[UIColor darkGrayColor]];
    [label setText:@"我的热闹"];
    [view setBackgroundColor:[UIColor clearColor]];
    [view addSubview:imageView];
    [view addSubview:label];
    return view;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<0) {
        for (NSLayoutConstraint *constraint in bgImage.constraints) {
            if (constraint.firstItem==bgImage) {
                if (constraint.firstAttribute==NSLayoutAttributeHeight) {
                    constraint.constant = 235+scrollView.contentOffset.y*-1;
                }
                if (constraint.firstAttribute==NSLayoutAttributeWidth) {
                    constraint.constant = 320+scrollView.contentOffset.y*-1;
                }
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
