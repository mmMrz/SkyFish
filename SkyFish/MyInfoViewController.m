//
//  MyInfoViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "MyInfoViewController.h"
#import "PersonPage.h"

@implementation MyInfoViewController{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController loadTheme];
    [self.navigationItem addTitleViewWithTitle:@"个人"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedLeftMenuButtonWithTarget:self andSelector:@selector(showLeftMenu:)]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupView];
}

- (void)showLeftMenu:(id)sender
{
    [self.baseController showHideLeftMenu];
}

- (void)setupView
{
    [signLbl setText:[GlobalData sharedInstance].currentUserInfo.sign];
    [nameLbl setText:[GlobalData sharedInstance].currentUserInfo.name];
    [weiboCount setText:[[GlobalData sharedInstance].currentUserInfo.blogCount stringValue]];
    [attentionCount setText:[GlobalData sharedInstance].currentUserInfo.cared];
    [fansCount setText:[GlobalData sharedInstance].currentUserInfo.fans];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[GlobalData sharedInstance].currentUserInfo.avatar, nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [headView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
}

- (IBAction)toMyPage:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PersonPage *personPage = [story instantiateViewControllerWithIdentifier:@"PersonPage"];
    [personPage setUid:[GlobalData sharedInstance].currentUserInfo.uid];
    [self.navigationController pushViewController:personPage animated:YES];
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
