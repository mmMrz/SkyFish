//
//  MyInfoViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "MyInfoViewController.h"

@implementation MyInfoViewController{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController loadTheme];
    [self.navigationItem addTitleViewWithTitle:@"个人"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedLeftMenuButtonWithTarget:self andSelector:@selector(showLeftMenu:)]];
}

- (void)showLeftMenu:(id)sender
{
    [self.baseController showHideLeftMenu];
}

- (void)setupView
{
    [signLbl setText:[GlobalData sharedInstance].currentUserInfo.sign];
    [nameLbl setText:[GlobalData sharedInstance].currentUserInfo.name];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[GlobalData sharedInstance].currentUserInfo.avatar, nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [headView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
}

- (IBAction)toMyPage:(UIButton *)sender {
}

- (IBAction)toMyWeibo:(UIButton *)sender {
}

- (IBAction)toMyAttention:(UIButton *)sender {
}

- (IBAction)toMyComment:(UIButton *)sender {
}

- (IBAction)toMyFavorite:(UIButton *)sender {
}

- (IBAction)toSetting:(UIButton *)sender {
}

@end
